PROJ=                   signal

CC=                     gcc
SZ=                     size
CFLAGS=                 -I$(INC_DIR)
LIBS=

SRC_DIR=                src
INC_DIR=                inc
BIN_DIR=                bin
OBJ_DIR=                obj

RM_RF=                  rm -rf
MKDIR_P=                mkdir -p
ECHO=                   echo
ECHO_N=                 echo -n

#################################################
C_SOURCES=              $(shell find $(SRC_DIR) -name '*.c')
OBJECTS =               $(addprefix $(OBJ_DIR)/,$(C_SOURCES:%.c=%.o))

#################################################
.PHONY: all
all: build $(OBJECTS)
	@$(ECHO_N)      ""

.PHONY: run
run: $(BIN_DIR)/$(PROJ)
	@./$<

.PHONY: clean
clean:
	@$(RM_RF)       $(BIN_DIR)
	@$(RM_RF)       $(OBJ_DIR)

#################################################

.PHONY: build
build: $(BIN_DIR)/$(PROJ)
	@$(ECHO_N)      ""

#################################################
$(BIN_DIR)/$(PROJ): $(OBJECTS)
	@$(ECHO_N)      "\tBuilding $@"
	@$(MKDIR_P)     $(dir $@)
	@$(CC)          -o $@ $^ $(CFLAGS) $(LIBS)
	@$(ECHO)        ""
	@$(SZ)          $@

$(OBJ_DIR)/%.o: %.c
	@$(ECHO_N)      "\tCompiling $<"
	@$(MKDIR_P)     $(dir $@)
	@$(CC)          -c -o $@ $< $(CFLAGS)
	@$(ECHO)        ""
