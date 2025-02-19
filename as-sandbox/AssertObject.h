#pragma once
#include <source_location>
#include <string_view>

namespace Sandbox
{
    struct AssertObject
    {
        std::string_view errorMessage;
        std::source_location location{};
        int index{};

        AssertObject(
            std::string_view errorMessage,
            const std::source_location& location = std::source_location::current());

        [[noreturn]] void throwError() const;
    };

    using namespace std::string_view_literals;

    struct AssertNonNegative : AssertObject
    {
        AssertNonNegative operator |(int value) const;
    };

    struct AssertNotNull : AssertObject
    {
        AssertNotNull operator |(void* ptr) const;
    };
}
