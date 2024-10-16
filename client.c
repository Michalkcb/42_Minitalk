/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mbany <mbany@student.42warsaw.pl>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/12 22:28:07 by mbany             #+#    #+#             */
/*   Updated: 2024/10/16 17:52:38 by mbany            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	send_char(int pid, char c)
{
	int	bit;

	bit = 0;
	while (bit < 8)
	{
		if ((c >> bit) & 1)
		{
			if (kill(pid, SIGUSR1) == -1)
			{
				ft_putstr("Error sending signal.\n");
				exit(EXIT_FAILURE);
			}
		}
		else
		{
			if (kill(pid, SIGUSR2) == -1)
			{
				ft_putstr("Error sending signal.\n");
				exit(EXIT_FAILURE);
			}
		}
		bit++;
		usleep(400);
	}
}

void	handle_confirmation(int signum)
{
	if (signum == SIGUSR1)
		ft_putstr("Message received by server.\n");
}

int	main(int argc, char **argv)
{
	int		pid;
	char	*message;
	int		i;

	if (argc != 3)
	{
		ft_putstr("Usage: ./client [server_pid] [message]\n");
		exit(EXIT_FAILURE);
	}
	pid = ft_atoi(argv[1]);
	message = argv[2];
	signal(SIGUSR1, handle_confirmation);
	i = 0;
	while (message[i])
	{
		send_char(pid, message[i]);
		i++;
	}
	send_char(pid, '\n');
	send_char(pid, '\0');
	return (0);
}
