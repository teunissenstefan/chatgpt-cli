% CHATGPT(1) ChatGPT-CLI User Manuals
% Stefan Teunissen
% December 14, 2022

# NAME

chatgpt - interact with ChatGPT from the terminal

# SYNOPSIS

chatgpt [*options*] *var*

# DESCRIPTION

ChatGPT-CLI is a way to interact with ChatGPT's API through the terminal.

If no *var* is specified, input is read from *stdin*. Output goes to 
*stdout* by default.

    chatgpt "What is love?"

    echo "What is love?" | chatgpt 

# OPTIONS

--max-tokens
:   The maximum number of tokens to generate in the completion. Most 
models have a context length of 2048 tokens (except for the newest 
models, which support 4096).

-m, \--model
:   ID of the model for ChatGPT to use.

-n
:   How many completions to generate for each prompt.

-t, \--temperature
:   What sampling temperature to use. Higher values means the model will 
take more risks. Try 0.9 for more creative applications, and 0 (argmax 
sampling) for ones with a well-defined answer.

# SEE ALSO

For more information about ChatGPT and its options, go to 
<https://beta.openai.com/docs/api-reference>.