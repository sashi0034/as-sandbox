#include "Callbacks.h"

#include <format>
#include <iostream>

namespace Sandbox
{
    void MessageCallback(const asSMessageInfo* msg, void* param)
    {
        auto type = "[error]";
        if (msg->type == asMSGTYPE_WARNING)
            type = "[warn] ";
        else if (msg->type == asMSGTYPE_INFORMATION)
            type = "[info] ";

        const auto message = std::format("{} {}({},{}) {}", type, msg->section, msg->row, msg->col, msg->message);
        if (msg->type == asMSGTYPE_INFORMATION)
        {
            std::cout << message << std::endl;
        }
        else
        {
            std::cerr << message << std::endl;
        }
    }
}
