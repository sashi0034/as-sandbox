#include <iso646.h>

#include "AssertObject.h"
#include "Callbacks.h"
#include "ScriptPredefined.h"
#include "angelscript/add_on/datetime/datetime.h"
#include "angelscript/add_on/scriptany/scriptany.h"
#include "angelscript/add_on/scriptarray/scriptarray.h"
#include "angelscript/add_on/scriptbuilder/scriptbuilder.h"
#include "angelscript/add_on/scriptdictionary/scriptdictionary.h"
#include "angelscript/add_on/scriptfile/scriptfile.h"
#include "angelscript/add_on/scriptfile/scriptfilesystem.h"
#include "angelscript/add_on/scriptgrid/scriptgrid.h"
#include "angelscript/add_on/scripthelper/scripthelper.h"
#include "angelscript/add_on/scriptmath/scriptmath.h"
#include "angelscript/add_on/scriptstdstring/scriptstdstring.h"
#include "angelscript/add_on/weakref/weakref.h"
#include "asbind20/bind.hpp"
#include "asbind20/generic.hpp"
#include "asbind20/ext/array.hpp"

using namespace Sandbox;

namespace
{
    void script_print(const std::string& message)
    {
        printf("%s", message.c_str());
    }

    void registerEngine(const asbind20::script_engine& engine)
    {
        // script extenstion: https://www.angelcode.com/angelscript/sdk/docs/manual/doc_addon_script.html
        RegisterStdString(engine);
        RegisterScriptArray(engine, true);
        RegisterScriptAny(engine);
        RegisterScriptWeakRef(engine);
        RegisterScriptDictionary(engine);
        RegisterScriptFile(engine);
        RegisterScriptMath(engine);
        RegisterScriptGrid(engine);
        RegisterScriptDateTime(engine);
        RegisterScriptFileSystem(engine);

        RegisterExceptionRoutines(engine);

        // asbind20: https://github.com/HenryAWE/asbind20/
        asbind20::global(engine)
            .message_callback(&MessageCallback)
            .function("void print(const string& in message)", &script_print);
    }
}

void main()
{
    const auto engine = asbind20::make_script_engine();

    registerEngine(engine);

    GenerateScriptPredefined(engine, "as-sandbox-code/as.predefined");

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
