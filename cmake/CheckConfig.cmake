if (NOT "${CMAKE_SYSTEM_PROCESSOR}" MATCHES "arm|aarch")
    message(FATAL_ERROR "Processor ${CMAKE_SYSTEM_PROCESSOR} is not supported for NE10")
endif()

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Android")

    # Android config
    if(NOT DEFINED ANDROID_NDK)
        message(FATAL_ERROR "Could not find Android NDK. You should set an environment variable: export ANDROID_NDK=/your/path/to/android/ndk")
    endif()

    if (NOT DEFINED ANDROID_PLATFORM)
        set(ANDROID_PLATFORM 21)
        message(WARNING "ANDROID_PLATFORM is not specified. Used by default ANDROID_PLATFORM=${ANDROID_PLATFORM}")
    endif()

    if (NOT DEFINED ANDROID_ABI)
        set(ANDROID_ABI "arm64-v8a")
        message(WARNING "ANDROID_ABI is not specified. Used by default ANDROID_ABI=${ANDROID_ABI}")
    endif()

    # Ne10 config wrapper
    set(ANDROID_API_LEVEL ${ANDROID_PLATFORM})
    set(NDK_SYSROOT_PATH ${CMAKE_SYSROOT})
    if (ANDROID_ABI STREQUAL "arm64-v8a")
        set(NE10_ANDROID_TARGET_ARCH "aarch64")
    elseif(ANDROID_ABI STREQUAL "armeabi-v7a")
        set(NE10_ANDROID_TARGET_ARCH "armv7")
    else()
        message(FATAL_ERROR "ANDROID_ABI=${ANDROID_ABI} not supported. Please select [arm64-v8a, armeabi-v7a]")
    endif()

elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")

    # Linux config
    set(GNULINUX_PLATFORM ON)
    if (CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
        set(NE10_LINUX_TARGET_ARCH "aarch64")
    elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch32")
        set(NE10_LINUX_TARGET_ARCH "armv7")
    else()
        message(FATAL_ERROR "NE10_TARGET_ARCH=${CMAKE_SYSTEM_PROCESSOR} not supported")
    endif()

endif()