#include <iostream>
#include <filesystem>
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

    void println(const std::string& message)
    {
        printf("%s\n", message.c_str());
    }

    struct flag_t
    {
        bool flag;

        operator bool() const
        {
            return flag;
        }
    };

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
            .function("void print(const string& in message)", &script_print)
            .function("void println(const string& in message)", &println);

        asbind20::value_class<flag_t>(engine, "flag_t", asOBJ_VALUE)
            .behaviours_by_traits()
            .constructor<bool>("bool flag")
            .opEquals()
            .opConv<bool>()
            .opImplConv<bool>()
            .property("bool flag", &flag_t::flag);
    }

    int includeCallback(const char* include, const char* from, CScriptBuilder* builder, void* userParam)
    {
        namespace fs = std::filesystem;
        const fs::path fromDir{from};
        const fs::path includePath{include};

        fs::path primaryPath = fromDir.parent_path() / includePath;
        if (fs::exists(primaryPath))
        {
            builder->AddSectionFromFile(primaryPath.string().c_str());
            return 0;
        }

        const fs::path fallbackDir = fs::current_path() / "include_fallback";
        const fs::path fallbackPath = fallbackDir / includePath;

        if (fs::exists(fallbackPath))
        {
            builder->AddSectionFromFile(fallbackPath.string().c_str());
            return 0;
        }

        return -1;
    }
}

int main(int argc, char** argv)
{
    // TODO: debug ビルドなら as.predefined 自動生成
    // TODO: 開始ファイルの設定ファイルを追加

    std::string moduleName{};
    if (argc > 1) moduleName = argv[1];
    else std::cin >> moduleName;

    if (not moduleName.ends_with(".as") && not moduleName.ends_with("as.predefined"))
    {
        std::cerr << "Invalid file extension" << std::endl;
        return 1;
    }

    // -----------------------------------------------

    const auto engine = asbind20::make_script_engine();

    registerEngine(engine);

    if (moduleName.ends_with("as.predefined"))
    {
        GenerateScriptPredefined(engine, moduleName);
        std::cout << "Generated 'as.predefined'" << std::endl;
        return 0;
    }

    CScriptBuilder builder{};
    builder.SetIncludeCallback(includeCallback, nullptr);

    if (builder.StartNewModule(engine, moduleName.c_str()) < 0)
    {
        std::cerr << "Failed to start a new module" << std::endl;
        return 1;
    }

    if (builder.AddSectionFromFile(moduleName.c_str()) < 0)
    {
        std::cerr << "Failed to add section from file" << std::endl;
        return 1;
    }

    if (builder.BuildModule() < 0)
    {
        std::cerr << "Failed to build module" << std::endl;
        return 1;
    }

    asIScriptModule* module = engine->GetModule(moduleName.c_str());
    if (not module)
    {
        std::cerr << "Failed to find module" << std::endl;
        return 1;
    }

    // -----------------------------------------------

    asIScriptFunction* func = module->GetFunctionByDecl("void main()");
    if (not func)
    {
        std::cerr << "Failed to find 'void main()'" << std::endl;
        return 1;
    }

    const asbind20::request_context ctx{engine};
    const auto result = asbind20::script_invoke<void>(ctx, func);
    if (not result.has_value())
    {
        std::cerr << "Failed to execute the script: " << result.error() << std::endl;
        // TODO: print exception
    }

    module->Discard();
}
