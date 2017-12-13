#include <sys/wait.h> 
#include <unistd.h> 
#include <stdlib.h> 
#include <stdio.h> 
#include <string.h>

#define HSHELL_LINE_BUFFOR 1024
#define HSHELL_WORD_BUFFOR 64
#define DELIMETERS " \""

//BUILTED HAJDUK_SHELL COMMANDS
int hsh_cd(char **args);
int hsh_dir(char **args);
int hsh_exit(char **args);
int hsh_help(char **args);

char *builted_commands[] = {"move", "wheremi", "close", "help"};
int (*builted_method[]) (char **) = {&hsh_cd, &hsh_dir, &hsh_exit, &hsh_help};

int number_commands_builted() {
    return sizeof(builted_commands) / sizeof(char *);
}

//BUILTED COMMENDS IMPLEMENTATIONS
int hsh_cd (char **args) {
    if (args[1] == NULL) {
        fprintf(stderr, "\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: GIVE ME DIRECTORY RETARTED ._.\e[0m\n");
    } else {
        if (chdir(args[1]) != 0) {
            perror("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m");
        }
    }
    return 1;
}

int hsh_dir (char **args) {
    char cwd[256];

    if (getcwd(cwd, sizeof(cwd)) != NULL)
        fprintf(stdout, "\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: CURRENT DIRECTORY: %s\e[0m\n", cwd);
    else
        perror("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: ERROR... ._.");   
}

int hsh_exit (char **args) {
    return 0;
}

int hsh_help (char **args) {
    int counter;
    printf("\e[1mMaciej Hajduk's SHELL\n");
    printf("Builted commands:\e[0m\n");

    for (counter = 0; counter < number_commands_builted(); counter++) {
        printf(" %s\n", builted_commands[counter]);
    }
}

//TO INIT SHELL WE WILL fork() SYSTEM CALL
//WE WILL USE exec() TO REPLACE IT WITH NEW PROGRAM
int hsh_launch(char **args, int appersand, int input, int output, int error_out, char *input_file, char *output_file) {

    pid_t pid, wpid;
    int status;

    pid = fork();
    if (pid == 0) {
        //CHILD PROCESS
        if(input)
            freopen(input_file, "r", stdin);
        if(output)
            freopen(output_file, "w+", stdout);
        if(error_out)
            freopen(output_file, "w+", stderr);
        if (execvp(args[0], args) == -1) {
            //IT EXPECTS PROGRAM NAME AND AN ARRAY (VECTOR)
            //P MEANS WE LET SYSTEM FIND PATH
            perror("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m");
        }
        exit(EXIT_FAILURE);
    } else if (pid < 0) {
        //ERROR FORKING
        perror("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m");
    } else if (!appersand) {
        //PARENT PROCESS, FORK SUCCESS
        do {
            wpid = waitpid(pid, &status, WUNTRACED);    
            //WE'RE WAITING FOR COMMAND TO FINISH RUNNING
            //waitpit() WAITS FOR PROCESS STATE TO CHANGE
        } while (!WIFEXITED(status) && !WIFSIGNALED(status));
    } else
        printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: PROCESS CREATED WITH PID: \e[1m\x1B[31m%d\x1B[0m\n",pid);
    return 1;
}

//EXECUTES PROGRAMS AND CONNECT ALL IN ONE PLACE
int hsh_executive(char **args, int appersand, int input, int output, int error_out, char *input_file, char *output_file) {

    int counter;
    if (args[0] == NULL) {
        //EMPTY COMMAND
        return 1;
    }

    for (counter = 0; counter < number_commands_builted(); counter++) {
        if (strcmp(args[0], builted_commands[counter]) == 0) {
            return (*builted_method[counter])(args);
        }
    }
    return hsh_launch(args, appersand, input, output, error_out, input_file, output_file);
}

//HANDLES WHEN PROGRAM FINDS PIPE
void hsh_pipe_handler(char **args) {

	//0 - OUTPUT 1 - INPUT
	int field_one[2], field_two[2];
	int num_of_commands = 0;
	char *command[256];
	pid_t pid;
	int boolean_end = 0;
	
    //VARIABLES USED ON LOOPS
    int variable = 0;
	int place = 0;
	int position = 0;
	int counter = 0;
	
	//CALCULATING NUMBER OF COMMANDS
	while (args[counter] != NULL) {
		if (strcmp(args[counter], "|") == 0)
			num_of_commands++;
		counter++;
	}
	num_of_commands++;
	
	//MAIN LOOP, PIPE THERE CONFIGURE STANDARD I/O AND EXECUTE IT
	while (args[place] != NULL && boolean_end != 1)
	{
		position = 0;
		//STORING THE COMMAND, THAT WILL BE EXECUTED
		while (strcmp(args[place],"|") != 0)
		{
			command[position] = args[place];
			place++;	
			if (args[place] == NULL)
			{
				//KEEP PROGRAM FROM ENTERING BACK TO THE LOOP WHEN THERES MORE COMMANDS
                boolean_end = 1;
				position++;
				break;
			}
			position++;
		}
		//LAST POSITION OF COMMAND HAVE TO BE NULL
		command[position] = NULL;
		place++;		
		
		//CONNECTING I/O DEPENDING OF THE ITERATION WE ARE
		if (variable % 2 != 0) {
			pipe(field_one); 		//FOR ODD I
		}
		else {
			pipe(field_two); 		//FOR EVEN I
		}
		
		pid=fork();
		
		if(pid==-1) {			
			if (variable != num_of_commands - 1) {
				if (variable % 2 != 0)
					close(field_one[1]); //FOR ODD I
				else
					close(field_two[1]); //FOR EVEN I
			}

			perror("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m");
			return;
		}

		if(pid==0)
		{
			//IF THERE IS FIRST COMMAND
			if (variable == 0)
				dup2(field_two[1], STDOUT_FILENO);
            //IF THERES LAST COMMAND, DEPENDING ITS ODD OR EVEN COMMAND WE WILL REPLACE INPUT
			else if (variable == num_of_commands - 1)
			{
				if (num_of_commands % 2 != 0)
				//FOR ODD NUMBER OF COMMANDS
					dup2(field_one[0], STDIN_FILENO);
				else
				//FOR EVEN NUMBER OF COMMANDS
					dup2(field_two[0], STDIN_FILENO);
			//IF WE ARE IN MIDDLE WE HAVE TO USE TWO PIPES 
			}
			else {
				//FOR ODD I
				if (variable % 2 != 0) {
					dup2(field_two[0], STDIN_FILENO); 
					dup2(field_one[1], STDOUT_FILENO);
				}
				//FOR EVEN I
				else {
					dup2(field_one[0], STDIN_FILENO); 
					dup2(field_two[1], STDOUT_FILENO);					
				} 
			}
			if (execvp(command[0], command) == -1) {
				kill(getpid(), SIGTERM);
			}		
		}
				
		//CLOSING DESCRIPTORS ON PARENT
		if (variable == 0)
			close(field_two[1]);
		else if (variable == num_of_commands - 1) {
			if (num_of_commands % 2 != 0)
				close(field_one[0]);
			else
				close(field_two[0]);
		}
		else {
			if (variable % 2 != 0) {					
				close(field_two[0]);
				close(field_one[1]);
			}
			else {					
				close(field_one[0]);
				close(field_two[1]);
			}
		}		
		waitpid (pid, NULL, 0);		
		variable++;	
	}
}

//SHELL TAKES WHITESPACES AS SEPARATORS
//SPLIT LINE TO WORDS
char **hsh_split_args(char *line) {

    int buffor_size = HSHELL_WORD_BUFFOR;
    int position = 0;
    char **words = malloc(buffor_size * sizeof(char*));
    char *word;

    if (!words) {
        fprintf(stderr, "\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: LEL THERE IS ERROR WITH ALLOCATION\n");
        exit(EXIT_FAILURE);
    }

    word = strtok(line, DELIMETERS);   //RETURNS POINTER TO THE FIRST WORD, ACTUALLY GIVES \0 ON THE END

    while (word != NULL) {
        words[position] = word;
        position++;

        //IF OVER BUFFER, REALLOCATE
        if (position >= buffor_size) {
            buffor_size += HSHELL_WORD_BUFFOR;
            words = realloc(words, buffor_size * sizeof(char*));
            
            if (!words) {
                fprintf(stderr, "\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: LEL THERE IS ERROR WITH ALLOCATION\n");
                exit(EXIT_FAILURE);
            }
        }
        word = strtok(NULL, DELIMETERS);
    }
    words[position] = NULL;
    return words;
}

//RETURNS THE LINE FROM STDIN
char *hsh_read_line (void) {

    int buffor_size = HSHELL_LINE_BUFFOR;
    int position = 0;
    char *buffer = malloc(sizeof(char) * buffor_size);
    int next_char;      //INT BECUASE EOF IS AN INT

    if (!buffer) {
        fprintf(stderr, "\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: LEL THERE IS ERROR WITH ALLOCATION\n");
        exit(EXIT_FAILURE);
    }

    while (1) {
        //READ CHAR BY CHAR
        next_char = getchar();

        //EXIT ON CTRL-D
        if (next_char == EOF) {
            exit(EXIT_SUCCESS);
        }

        //IF EOF, REPLACE WITH NULL
        if (next_char == EOF || next_char == '\n') {
            buffer[position] = '\0';
            return buffer;
        } else {
            buffer[position] = next_char;
        }
        position++;

        //IF OVER BUFFER, REALLOCATE
        if (position >= buffor_size) {
            buffor_size += HSHELL_LINE_BUFFOR;
            buffer = realloc(buffer, buffor_size);
            if (!buffer) {
                fprintf(stderr, "\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: LEL THERE IS ERROR WITH ALLOCATION\n");
                exit(EXIT_FAILURE);
            }
        }
    }
}

//CHECK FOR ERROR
int hsh_error_output(char **args, char **output_file) {
    int counter;
    int variable;

    for(counter = 0; args[counter] != NULL; counter++) {
        //LOOK FOR >
        if(args[counter][0] == '^') {
            args[counter] == NULL;
            //GET FILENAME
            if(args[counter+1] != NULL) {
    	        *output_file = args[counter+1];
            } else {
    	        return -1;
            }
            //ADJUST ARGUMENTS IN THE ARRAY
            for(variable = counter; args[variable-1] != NULL; variable++) {
	            args[variable] = args[variable+2];
            }
            return 1;
        }
    }
    return 0;
}

//CHECK FOR INPUT
int hsh_redirect_input(char **args, char **input_file) {
    int counter;
    int variable;

    for(counter = 0; args[counter] != NULL; counter++) {
        //LOOK FOR <
        if(args[counter][0] == '<') {
            args[counter] == NULL;
            //GET FILENAME
            if(args[counter+1] != NULL) {
    	        *input_file = args[counter+1];
            } else {
    	        return -1;
            }
            //ADJUST ARGUMENTS IN THE ARRAY
            for(variable = counter; args[variable-1] != NULL; variable++) {
	            args[variable] = args[variable+2];
            }
            return 1;
        }
    }
    return 0;
}

//CHECK FOR OUTPUT
int hsh_redirect_output(char **args, char **output_file) {
    int counter;
    int variable;

    for(counter = 0; args[counter] != NULL; counter++) {
        //LOOK FOR >
        if(args[counter][0] == '>') {
            args[counter] == NULL;
            //GET FILENAME
            if(args[counter+1] != NULL) {
    	        *output_file = args[counter+1];
            } else {
    	        return -1;
            }
            //ADJUST ARGUMENTS IN THE ARRAY
            for(variable = counter; args[variable-1] != NULL; variable++) {
	            args[variable] = args[variable+2];
            }
            return 1;
        }
    }
    return 0;
}

//CHECK IF THERES PIPE
int hsh_pipe_input(char **args) {
    int counter;
    for(counter = 0; args[counter] != NULL; counter++) {
        //LOOK FOR |
        if(args[counter][0] == '|') {
            return 1;
        }
    }
}

//CHECK FOR APPERSAND
int hsh_ampersand(char **args) {
    int counter;
    for(counter = 1; args[counter] != NULL; counter++);
    if(args[counter-1][0] == '&') {
        args[counter-1] = NULL;
        return 1;
    } else
        return 0;
}

//HAJDUK SHELL DIRECTING INFO
void hsh_info (int input, int output, int error_out, char *input_file, char *output_file) {

    switch(input) {
        case -1:
            printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: SYNTAX ERROR ._.\e[0m\n");
            break;
        case 0:
            break;
        case 1:
            printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: REDIRECTING FROM:\e[0m %s\n", input_file);
        break;
    } 

    switch(output) {
        case -1:
            printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: SYNTAX ERROR ._.\e[0m\n");
            break;
        case 0:
            break;
        case 1:
            printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: REDIRECTING TO:\e[0m %s\n", output_file);
        break;
    } 

    switch(error_out) {
        case -1:
            printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: SYNTAX ERROR ._.\e[0m\n");
            break;
        case 0:
            break;
        case 1:
            printf("\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: REDIRECTING ERRORS TO:\e[0m %s\n", output_file);
        break;
    }
}

//MAIN SHELL LOOP
void hsh_loop (void) {

    //JUST DECLARATIONS
    char *line, *output_file, *input_file;
    char **args;
    char cwd[256];
    int status, output, input, error_out, appersand;

    do {
        if (getcwd(cwd, sizeof(cwd)) != NULL)
            fprintf(stdout, "\n\e[1m\x1B[36mOKKINDEL (\x1B[33m %s \x1B[36m)\n$\e[0m ", cwd);                //PROMPT SIGN

        line = hsh_read_line();                                                                             //READ LINE
        args = hsh_split_args(line);                                                                        //SPLIT ARGUMENTS
        if (hsh_pipe_input(args))                                                                           //CHECK IF THERES PIPE
            hsh_pipe_handler(args);                                                                         //EXECUTE PIPE HANDLER
        else {
            appersand = hsh_ampersand(args);                                                                //CHECK FOR APPERSAND
            input = hsh_redirect_input(args, &input_file);                                                  //CHECK FOR INDIRECT
            output = hsh_redirect_output(args, &output_file);                                               //CHECK FOR REDIRECT
            error_out = hsh_error_output(args, &output_file);                                               //CHECK FOR ERRORS
            hsh_info(input, output, error_out, input_file, output_file);                                    //CONSOLE OUTPUT
            status = hsh_executive(args, appersand, input, output, error_out, input_file, output_file);     //EXECUTE ARGUMENTS
        }
        free(line);
        free(args);
    } while (status);
}

//CTRL-C HANDLERS
void intHandler(int state) {
    fprintf(stderr, "\n\e[1m\x1B[31mHAJDUK_SHELL\x1B[0m: PULL CTRL-D TO EXIT\e[0m\n ");
    hsh_loop();
}

//MAIN METHOD
int main (int argc, char **argv) {

    signal(SIGINT, intHandler);
    hsh_loop();
    return EXIT_SUCCESS; 
}