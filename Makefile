#
# This is a project Makefile. It is assumed the directory this Makefile resides in is a
# project subdirectory.
#

############# MAKE AGENTSPEAK CODE TRANSLATION AND FLASH TO BOARD #############

interface=/dev/ttyUSB0

translate:
	javac -cp main/embedded-bdi/lib/parser/lib/jason-2.6.jar                     \
            main/embedded-bdi/lib/parser/src/translator/As2Json.java           \
            main/embedded-bdi/lib/parser/src/translator/PlanSkeleton.java      \
            main/embedded-bdi/lib/parser/src/translator/BodyInstruction.java   \
            main/embedded-bdi/lib/parser/src/translator/EventOperatorType.java \
            main/embedded-bdi/lib/parser/src/translator/HeaderCreator.java

	java -cp main/embedded-bdi/lib/parser/lib/jason-2.6.jar:main/embedded-bdi/lib/parser/src    \
           translator.As2Json                                               									\
           main/data/agentspeak.asl                                         									\
           main/data/functions.h                                            									\
           main/src/config/configuration.h                                   								  \
           $(EVENT_BASE_SIZE) $(INTENTION_BASE_SIZE) $(INTENTION_STACK_SIZE)

agent: translate
	idf.py -p $(interface) flash monitor

-include agent.config

######################## DEFAULT IDF MAKEFILE #################################

PROJECT_NAME := agent-loop

include $(IDF_PATH)/make/project.mk