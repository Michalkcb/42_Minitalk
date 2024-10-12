# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbany <mbany@student.42warsaw.pl>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/12 22:28:38 by mbany             #+#    #+#              #
#    Updated: 2024/10/12 13:08:13 by mbany            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC			= clang
CFLAGS		= -Wall -Wextra -Werror
RM			= rm -rf
LIBFT_DIR	= ./Libft
LIBFT		= $(LIBFT_DIR)/libft.a
SRCS		= server.c client.c
OBJS		= $(SRCS:.c=.o)

all:	$(LIBFT) client server

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

client: client.o $(LIBFT)
	$(CC) $(CFLAGS) -o client client.o $(LIBFT) -I$(LIBFT_DIR)

server: server.o $(LIBFT)
	$(CC) $(CFLAGS) -o server server.o $(LIBFT) -I$(LIBFT_DIR)

%.o:	%.c
	$(CC) $(CFLAGS) -I$(LIBFT_DIR) -c $< -o $@

clean:
	@$(RM) $(OBJS)
	$(MAKE) -C $(LIBFT_DIR) clean
	
fclean:
	@$(RM) client server
	$(MAKE) -C $(LIBFT_DIR) fclean

re: fclean all

.PHONY: all clean fclean re