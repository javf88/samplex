set(TARGET wiced_sdk)

add_library(${TARGET}
    # GLOBAL is required, otherwise it would not be consumed
    STATIC IMPORTED GLOBAL)

set_target_properties(${TARGET} PROPERTIES
    IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/lib/libwiced.a)

target_include_directories(${TARGET}
    INTERFACE include)
