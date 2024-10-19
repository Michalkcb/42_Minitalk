# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbany <mbany@student.42warsaw.pl>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/12 22:28:38 by mbany             #+#    #+#              #
#    Updated: 2024/10/16 17:55:49 by mbany            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = cc
CFLAGS = -Wall -Wextra -Werror

SERVER = server
CLIENT = client

SRCS = server.c client.c utils.c

OBJDIR = obj
OBJS = $(SRCS:%.c=$(OBJDIR)/%.o)

DEPS = minitalk.h

all: $(SERVER) $(CLIENT)

$(SERVER): $(OBJDIR)/server.o $(OBJDIR)/utils.o
	$(CC) $(CFLAGS) -o $(SERVER) $(OBJDIR)/server.o $(OBJDIR)/utils.o

$(CLIENT): $(OBJDIR)/client.o $(OBJDIR)/utils.o
	$(CC) $(CFLAGS) -o $(CLIENT) $(OBJDIR)/client.o $(OBJDIR)/utils.o

$(OBJDIR)/%.o: %.c $(DEPS)
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR)

fclean: clean
	rm -f $(SERVER) $(CLIENT)

re: fclean all

.PHONY: all clean fclean re