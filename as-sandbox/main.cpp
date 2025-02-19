#include <iso646.h>

#include "AssertObject.h"
#include "Callbacks.h"
#include "angelscript/add_on/scriptbuilder/scriptbuilder.h"
#include "angelscript/add_on/scriptstdstring/scriptstdstring.h"
#include "asbind20/bind.hpp"
#include "asbind20/generic.hpp"
#include "asbind20/ext/array.hpp"

using namespace Sandbox;

namespace
{
    class my_value_class
    {
    public:
        my_value_class() = default;
        my_value_class(const my_value_class&) = default;

        explicit my_value_class(int val)
            : value(val)
        {
        }

        ~my_value_class() = default;

        my_value_class& operator=(const my_value_class&) = default;

        friend bool operator==(const my_value_class& lhs, const my_value_class& rhs)
        {
            return lhs.value == rhs.value;
        }

        friend std::strong_ordering operator<=>(const my_value_class& lhs, const my_value_class& rhs)
        {
            return lhs.value <=> rhs.value;
        }

        int get_val() const
        {
            return value;
        }

        void set_val(int new_val)
        {
            value = new_val;
        }

        // Can be found by ADL in C++ code
        friend void process(my_value_class& val)
        {
            val.value += 10;
        }

        int value = 0;
        int another_value = 0;
    };

    void add_obj_last(int val, my_value_class* this_)
    {
        this_->value += val;
    }

    void mul_obj_first(my_value_class* this_, int val)
    {
        this_->value *= val;
    }

    void set_val_gen(asIScriptGeneric* gen)
    {
        my_value_class* this_ = asbind20::get_generic_object<my_value_class*>(gen);
        int val = asbind20::get_generic_arg<int>(gen, 0);
        this_->set_val(val);
    }

    // -----------------------------------------------

    void print(std::string& msg)
    {
        printf("%s", msg.c_str());
    }
}

void main()
{
    const auto engine = asbind20::make_script_engine();

    asbind20::value_class<my_value_class>(
            engine,
            "my_value_class",
            // Other flags will be automatically set using asGetTypeTraits<T>()
            asOBJ_APP_CLASS_ALLINTS | asOBJ_APP_CLASS_MORE_CONSTRUCTORS
        )
        // Generate & register the default constructor, copy constructor, destructor,
        // and assignment operator (operator=/opAssign) based on type traits
        .behaviours_by_traits()
        // The constructor `my_value_class::my_value_class(int val)`
        // The tag `use_explicit` indicates an explicit constructor.
        .constructor<int>("int val", asbind20::use_explicit)
        // Generate opEquals for AngelScript using operator== in C++
        .opEquals()
        // Generate opCmp for AngelScript using operator<=> in C++,
        // translating comparison result from the C++ enum to int value for AS.
        .opCmp()
        // Ordinary member functions
        .method("int get_val() const", &my_value_class::get_val)
        // Automatically deducing calling conventions for wrapper functions.
        .method("void add(int val)", &add_obj_last) // asCALL_CDECL_OBJLAST
        .method("void mul(int val)", &mul_obj_first) // asCALL_CDECL_OBJFIRST
        .method("void set_val(int)", &set_val_gen) // asCALL_GENERIC
        // Use lambda to bind a function found by ADL
        .method(
            "void process()",
            [](my_value_class& val) -> void { process(val); }
        )
        // Register property by member pointer.
        .property("int value", &my_value_class::value)
        // Register property by offset.
        .property("int another_value", offsetof(my_value_class, another_value));

    RegisterStdString(engine);

    asbind20::global(engine)
        .message_callback(&MessageCallback)
        .function("void print(const string& in)", &print);

    std::string moduleName = "hello";
    CScriptBuilder builder{};

    AssertNonNegative{"failed to build module"sv}
        | builder.StartNewModule(engine, moduleName.c_str())
        | builder.AddSectionFromFile("as-sandbox-code/hello.as")
        | builder.BuildModule();

    asIScriptModule* module = engine->GetModule(moduleName.c_str());

    asIScriptFunction* func = module->GetFunctionByDecl("void main()");
    AssertNotNull{"function not found"sv} | func;

    asbind20::request_context ctx{engine};
    const auto result = asbind20::script_invoke<void>(ctx, func);
    if (not result.has_value())
    {
        printf("Failed to execute the script: %d\n", result.error());
        // print asEXECUTION_EXCEPTION
    }

    module->Discard();
}
