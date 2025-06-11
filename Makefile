NAME 	:= asm_lib # Name of the library

SRC 	:= $(wildcard *.s)

OBJ_DIR := ./obj

OBJ 	:= $(addprefix $(OBJ_DIR)/,$(SRC:.s=.o))

CC	  := gcc # Compiler to use

all: $(NAME)

run: all
	@echo "Running the library..."
	./$(NAME)

$(NAME): $(OBJ)
	$(CC) main.c  $(OBJ) -o $(NAME)

$(OBJ_DIR)/%.o: %.s | $(OBJ_DIR)
	@mkdir -p $(OBJ_DIR)
	nasm -f elf64 -F dwarf $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

clean:
	@rm -rf $(OBJ_DIR)

fclean: clean
	@rm -f $(NAME)

re: fclean all

.PHONY: all run clean fclean re

