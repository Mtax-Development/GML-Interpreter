**GML Interpreter** is a tool allowing for execution of GameMaker Language code during the runtime of compiled GameMaker applications. It can read a specified string or text file containing human-readable code, create an approximation of the chain of instructions that code is meant to execute, and execute them within a running application while storing data that script operates on. This is useable for variety of purposes, as it allows to both separate pieces of code from a compliled application and for them to change during the runtime. One notable use is the introduction of code modding capabilities in GameMaker versions that no longer support executing code from strings, due to differences in architecture of GameMaker itself.

Please be aware that executing external code is a security liability and including such capability in a video game could cause certain vendors to reject its inclusion in their stores, particularly in case of video game consoles. For these reasons, not all capabilities of GameMaker Language are meant to be supported by this tool and this tool itself is currently at early stages of development.

This library is intended to be compatible with the first LTS version of GameMaker, but should be useable in later versions.

# Initialization
Setting up the interpreter for use involves three steps described below: importing code package from this repository into a project, including its dependencies, and creating a script with list of built-in functions that will be useable during code interpretation.

### Creating a package and importing it
1. Clone this repository.
2. Open the project of the cloned repository in GameMaker.
3. In the `Tools` toolbar, open the `Create Local Package` menu.
4. In `Package Details`, fill `Display name` and `Package ID (Filename)` fields with any name, also select `Add All` in the resource selection. Then select `OK`.
5. Select where the package file should be saved on the device.
6. Open the project in GameMaker into which the package will be imported.
7. In the `Tools` toolbar, open the `Import Local Package` menu.
8. Choose the previously saved package file and open it.
9. Choose `Add All` and then `Import`. The release should now be imported and appear in the `Asset Browser`, unless files with the same name have already existed in the project, in which case they can be replaced or skipped.
10. Confirm that each individual file was imported successfully.

### Including the dependencies
This project uses the following script files from other free and open-source libraries:
* [`array()`](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/array/array.gml) and [`file_to_string()`](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/file_to_string/file_to_string.gml) from [GML Development Toolbox](https://github.com/Mtax-Development/GML-Development-Toolbox).
* [`StringParser`](https://raw.githubusercontent.com/Mtax-Development/GML-OOP/master/scripts/StringParser/StringParser.gml) and [`ErrorReport`](https://raw.githubusercontent.com/Mtax-Development/GML-OOP/master/scripts/ErrorReport/ErrorReport.gml) from [GML-OOP](https://github.com/Mtax-Development/GML-OOP).

1. Visit the link of each raw script file linked above. Then perform steps below for each of them.
2. Select and copy the entire file. (Keyboard shortcuts: `Ctrl+A` to select the entire file, `Ctrl+C` to copy it.)
3. In GameMaker with opened project that **GML Interpreter** was included to, create a script file with the name of currently copied script. (Keyboard shortcuts: `Alt+C` to create a script file, `F2` to rename the created file.)

Alternatively, entire content of repositories linked above can be imported to the project, according to instructions found in each repository.

### Creating the function list
Execution of interpreted code relies on the [`get_function()`](https://github.com/Mtax-Development/GML-Interpreter/blob/master/scripts/get_function/get_function.gml) script file. By default, it does not contain a function declaration. This file is up to the individual developer to create and control the limitations of the interpreter. It is intended to contain a function with that name, which takes a single string argument containing a function name to be searched in the pool of supported names to return its function index, used later to execute it. This project contains two scripts described below, which can automate the process of creating this function.

The [`create_function_listing()`](https://github.com/Mtax-Development/GML-Interpreter/blob/master/scripts/create_function_listing/create_function_listing.gml) script returns an array of supported function names and works in two different ways, depending on whether path to a text file was specified as its only argument:
* Path was specified: The script will attempt to read a function name in each line. That function name needs to contain the `(` symbol, signifying it is a function name. This approach is designed to work with the file named with a variation of `fnames`, found in the installation folder of GameMaker and its `TextEditor` subfolder. It contains some of function names used by that GameMaker installation.
* Path was not specified: The script will attempt to iterate through function indexes, provided by the runtime currently executing it, to create a function list automatically. The result depends on the version of GameMaker, but should be agnostic to license used with it.

The [`write_function_pairing()`](https://github.com/Mtax-Development/GML-Interpreter/blob/master/scripts/write_function_pairing/write_function_pairing.gml) script can be used with an array as its second argument, containing strings with function names and no other symbols around that name, even the previously mentioned `(` symbol. The first argument is the file path to a script file meant to be filled. This can be the `get_function()` script file in the project, found in the project folder root and `scripts/get_function` subfolder. If the project was modified in that way, while opened in GameMaker, a prompt might appear about project files being modified by external sources. Choose "Reload" to load the project again with these changes applied.

The `Disable file system sandbox` option needs to be enabled in the project settings for currently used export target, so the excecuted application is be able to read files on the device freely.

# Usage
1. Call [`script_interpret()`](https://github.com/Mtax-Development/GML-Interpreter/blob/master/scripts/script_interpret/script_interpret.gml) and obtain an interpretation array from its returned value. This function takes a single string argument containg the script to interpret, as obtained from the result of [`file_to_string()`](https://github.com/Mtax-Development/GML-Development-Toolbox/blob/master/scripts/file_to_string/file_to_string.gml) call or by other means. This part is generally slow to execute, but its result can be stored for later use. It is recommended to be performed while immediate performance is not necessary, such as during the loading phase of the application.
2. Call [`script_execute_interpretation()`](https://github.com/Mtax-Development/GML-Interpreter/blob/master/scripts/script_execute_interpretation/script_execute_interpretation.gml) using previously obtained interpretaton array as the second argument. The first argument is a struct that will be the scope of the execution, through the [`with`](https://manual.yoyogames.com/GameMaker_Language/GML_Overview/Language_Features/with.htm) statement. Properties of that struct will be accessible from the executed script and object variables it creates will be saved to it.

If the script contains an error, it will be reported through the [`ErrorReport`](https://github.com/Mtax-Development/GML-OOP/blob/master/scripts/ErrorReport/ErrorReport.gml) constructor during both of these steps.

# Credits
Created and maintained by [Mtax](https://github.com/Mtax-Development).

GameMaker and GameMaker Language are properties of YoYo Games.    
This is a third-party project not affiliated with YoYo Games.
