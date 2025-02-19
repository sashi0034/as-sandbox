#include "Callbacks.h"

#include <cstdio>

namespace Sandbox
{
    void MessageCallback(const asSMessageInfo* msg, void* param)
    {
        auto type = "[error]";
        if (msg->type == asMSGTYPE_WARNING)
            type = "[warn] ";
        else if (msg->type == asMSGTYPE_INFORMATION)
            type = "[info] ";

        printf("%s %s(%d,%d) %s\n", type, msg->section, msg->row, msg->col, msg->message);
    }
}
