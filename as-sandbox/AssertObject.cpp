#include "AssertObject.h"

#include <assert.h>
#include <iostream>
#include <stdexcept>
#include <string>

namespace Sandbox
{
    AssertObject::AssertObject(std::string_view errorMessage, const std::source_location& location) :
        errorMessage(errorMessage),
        location(location)
    {
    }

    void AssertObject::throwError() const
    {
        std::string message{errorMessage};
        message += " [" + std::to_string(index) + "]";
        // message += " at " + std::string(location.file_name());

        std::cerr << message << std::endl;

        assert(false);

        if (not errorMessage.empty()) throw std::runtime_error(std::string(errorMessage));
        else throw std::runtime_error("An error occurred");
    }

    AssertNonNegative AssertNonNegative::operator|(int value) const
    {
        if (value < 0) throwError();

        auto next = *this;
        next.index++;
        return next;
    }

    AssertNotNull AssertNotNull::operator|(void* ptr) const
    {
        if (ptr == nullptr) throwError();

        auto next = *this;
        next.index++;
        return next;
    }
}
