# Selects a Java compiler.
#
# Inputs:
#	CUSTOM_JAVA_COMPILER -- "eclipse", "openjdk". or nothing for the system
#                           default
#	ALTERNATE_JAVAC -- the alternate java compiler to use
#
# Outputs:
#   COMMON_JAVAC -- Java compiler command with common arguments
#

common_jdk_flags := -source 1.7 -target 1.7 -Xmaxerrs 9999999

# Use the indexer wrapper to index the codebase instead of the javac compiler
ifeq ($(ALTERNATE_JAVAC),)
JAVACC := javac
else
JAVACC := $(ALTERNATE_JAVAC)
endif

# The actual compiler can be wrapped by setting the JAVAC_WRAPPER var.
ifdef JAVAC_WRAPPER
    ifneq ($(JAVAC_WRAPPER),$(firstword $(JAVACC)))
        JAVACC := $(JAVAC_WRAPPER) $(JAVACC)
    endif
endif

# Whatever compiler is on this system.
ifeq ($(BUILD_OS), windows)
    COMMON_JAVAC := development/host/windows/prebuilt/javawrap.exe -J-Xmx256m \
<<<<<<< HEAD
        $(common_jdk_flags)
else
    COMMON_JAVAC := $(JAVACC) -J-Xmx1024M $(common_jdk_flags)
=======
        -target 1.5 -source 1.5 -Xmaxerrs 9999999
else
    COMMON_JAVAC := javac -J-Xmx512M -target 1.5 -source 1.5 -Xmaxerrs 9999999
>>>>>>> cd0afdc... KitKat AOSP initial commit
endif

# Eclipse.
ifeq ($(CUSTOM_JAVA_COMPILER), eclipse)
    COMMON_JAVAC := java -Xmx256m -jar prebuilt/common/ecj/ecj.jar -5 \
        -maxProblems 9999999 -nowarn
    $(info CUSTOM_JAVA_COMPILER=eclipse)
endif

<<<<<<< HEAD
=======
# OpenJDK.
ifeq ($(CUSTOM_JAVA_COMPILER), openjdk)
    # We set the VM options (like -Xmx) in the javac script.
    COMMON_JAVAC := prebuilt/common/openjdk/bin/javac -target 1.5 \
        -source 1.5 -Xmaxerrs 9999999
    $(info CUSTOM_JAVA_COMPILER=openjdk)
endif
   
>>>>>>> cd0afdc... KitKat AOSP initial commit
HOST_JAVAC ?= $(COMMON_JAVAC)
TARGET_JAVAC ?= $(COMMON_JAVAC)

#$(info HOST_JAVAC=$(HOST_JAVAC))
#$(info TARGET_JAVAC=$(TARGET_JAVAC))
