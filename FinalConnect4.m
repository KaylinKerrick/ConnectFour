% Connect Four Game
clear
clc
playAgain = true;
% Load in sprite sheet
while(playAgain)
    board = simpleGameEngine('connectfoursprites.png',85,85)
    
    fprintf('Welcome to Connect Four!\n')
    fprintf('Grab a friend to begin playing :)\n')
    
    blank_board = 2 * ones(6, 7);
    drawScene(board, blank_board);
    title('Begin game!')
    
    % player one begins with yellow
    color = 3; % yellow chip
    gameover = false; % the game is not over yet
    while ~gameover % while the game is not over...
        [r, c, ~] = getMouseInput(board); % get user input, which column do they click?
         % get the chip to fall to last available row
        row = find(blank_board(:, c) == 2, 1, 'last');
        % checks the column and if the sprite is equal to 2 (blank spot)
        % 1 specifies that the first blank spot available is chosen
        % Last is to find the last occurrence of this match
        
        if isempty(row)  % Check if the column is full
            break; % End game if the column is full 
        end
    
        blank_board(row, c) = color; % Place the piece
        drawScene(board, blank_board); % Update the board display
    
        % Check whether the current player has won and end the game immediately
        if win(blank_board, color)
            gameover = true;
            if color == 3
                title("Game Over: Player 1 Wins!"); %player1 win
            else
                title("Game Over: Player 2 Wins!"); %player2 win
            end
            break; %if one of players win, exit the game
        end
    
        % Alternate turns and color
        if color == 3
            color = 4; % player 2 (red)
        else
            color = 3; % player 1 (yellow)
        end
    end
    play = input('Type Y to play again: ', 's')
    if play == 'Y'
        playAgain = true;
    else
        playAgain = false;
    end
end
fprintf("Thanks for playing! Goodbye!!")


% User-defined function to check for a win
%%
function CheckWin = win(board, piece)
    CheckWin = false; % Initialize to false
    [rows, cols] = size(board);

    % Horizontal check
    for r = 1:rows
        for c = 1:(cols-3)
            if all(board(r, c:c+3) == piece)
                CheckWin = true;
                return;
            end
        end
    end

    % Vertical check
    for c = 1:cols
        for r = 1:(rows-3)
            if all(board(r:r+3, c) == piece) %all() makes sure that all pieces are of the same color
                CheckWin = true;
                return;
            end
        end
    end

    % Diagonal check 1 (\)
    for r = 1:(rows-3) %Goes through all the rows
        for c = 1:(cols-3) % goes through all the columns
            if all(diag(board(r:r+3, c:c+3)) == piece) %Looks at the 4x4 matrix starting with r and c and checks for same piece in a diagonal
                CheckWin = true;
                return;
            end
        end
    end

    % Diagonal check 2 (/)
    for r = 4:rows 
        for c = 1:(cols-3)
            if all(diag(flipud(board(r-3:r, c:c+3))) == piece) %flipud flips the matrix around to check for the diagonal
                CheckWin = true;
                return;
            end
        end
    end
end