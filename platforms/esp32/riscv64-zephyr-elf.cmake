# Toolchain file for ESP32-H2 using Zephyr RISC-V toolchain
# Assumes zephyr-sdk is available in PATH

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

# Toolchain prefix
set(TOOLCHAIN_PREFIX riscv64-zephyr-elf-)

# Compilers
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc CACHE STRING "C Compiler")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++ CACHE STRING "CXX Compiler")
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER} CACHE STRING "ASM Compiler")

# Archiver and other tools
set(CMAKE_AR ${TOOLCHAIN_PREFIX}ar CACHE FILEPATH "Archiver")
set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}ranlib CACHE FILEPATH "Ranlib")
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy CACHE FILEPATH "Objcopy")
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}objdump CACHE FILEPATH "Objdump")
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}size CACHE FILEPATH "Size")

# RISC-V architecture flags for ESP32-H2 (RV32IMAC)
set(ARCH_FLAGS "-mabi=ilp32 -march=rv32imac_zicsr_zifencei -mcmodel=medlow")

# Common flags
string(CONCAT COMMON_FLAGS
    "${ARCH_FLAGS}"
    " -fno-strict-aliasing"
    " -fno-common"
    " -fno-pic"
    " -fno-pie"
    " -fno-asynchronous-unwind-tables"
    " -ftls-model=local-exec"
    " -fno-reorder-functions"
    " --param=min-pagesize=0"
    " -fno-defer-pop"
    " -ffunction-sections"
    " -fdata-sections"
    " -fstrict-volatile-bitfields"
    " -fno-printf-return-value"
    " -fdiagnostics-color=always"
    " -specs=picolibc.specs"
)

# Warning flags
string(CONCAT WARNING_FLAGS
    " -Wall"
    " -Wformat"
    " -Wformat-security"
    " -Wno-format-zero-length"
    " -Wdouble-promotion"
    " -Wno-pointer-sign"
    " -Wpointer-arith"
    " -Wexpansion-to-defined"
    " -Wno-unused-but-set-variable"
    " -Werror=implicit-int"
)

# C/C++ flags
set(CMAKE_C_FLAGS_INIT "${COMMON_FLAGS} ${WARNING_FLAGS} -std=c17" CACHE STRING "Initial C flags")
set(CMAKE_CXX_FLAGS_INIT "${COMMON_FLAGS} ${WARNING_FLAGS} -fno-exceptions -fno-rtti" CACHE STRING "Initial CXX flags")
set(CMAKE_ASM_FLAGS_INIT "${ARCH_FLAGS}" CACHE STRING "Initial ASM flags")

# Optimization and debug flags
set(CMAKE_C_FLAGS_DEBUG_INIT "-Os -g -gdwarf-4" CACHE STRING "Debug C flags")
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-Os -g -gdwarf-4" CACHE STRING "Debug CXX flags")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--gc-sections --oslib=semihost" CACHE STRING "Initial linker flags")

# Don't try to run compiled binaries during CMake configuration
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
