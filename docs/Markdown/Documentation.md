# Documentation

The documentation is managed with [Jazzy](https://github.com/realm/jazzy).

## How to write your comments

For your comments to count as documentation, they should be written with either three slashes at the beginning of each line :

````
/// This will appear in the documentation for the func.
func someFunc() {}
````

Or the slash/asterisk sequence that resembles this :

````
/**
	Same here.
 */
func someOtherFunc() {}
````

The syntax is mainly markdown.

## Advanced example

Consider the following declaration :
````
/**
    Another complicated function.
 
    - Parameter fullname: The fullname that will be broken into its parts.
    - Returns: A *tuple* with the first and last name.
 
    - Remark:
        There's a counterpart function that concatenates the first and last name into a full name.
    - SeeAlso:  `createFullName(_:lastname:)`
    - Precondition: `fullname` should not be nil.
    - Requires: Both first and last name should be parts of the full name, separated with a *space character*.
    - Todo: Support middle name in the next version.
    - Warning: A wonderful **crash** will be the result of a `nil` argument.
    - Version: 1.1
    - Author: Myself Only
    - Note: Too much documentation for such a small function.
 */
func breakFullName(fullname: String) -> (firstname: String, lastname: String) {
    let fullnameInPieces = fullname.componentsSeparatedByString(" ")
    return (fullnameInPieces[0], fullnameInPieces[1])
}
````

It would produce the following documentation in XCode :

![enter image description here](https://www.appcoda.com/wp-content/uploads/2016/05/t52_10_keywords5.png)

Note that the Jazzy-generated doc will look different, but if something renders well within XCode, it should also render properly in the doc.

Using backquotes \` around your own symbols names will produce a link to this symbol's documentation (Jazzy only).

See [more advanced examples](https://www.appcoda.com/swift-markdown/).

## Jazzy usage

### Prerequisites

> [sudo] gem install jazzy

### Review configuration

Check out the `.jazzy.yaml` config file. Here you will see all the options that are passed to Jazzy when invoked.

Pay attention to the `custom_categories` part. Since we want to group our documented entities depending on their story and not their type, we specify in which custom category each symbol will go.

If you implement new symbols and they are not referenced in the `.jazzy.yaml` file, they will go to the `Other ...` categories.

### Add Markdown files

Every `.md` file you put in the `docs/Markdown/` folder will result in a new symbol.

The rules about `custom_categories` also apply with these files.

### Generate the doc

To generate the documentation, juste type the following command from the project's root folder (the same folder that contains `.jazzy.yaml`) :
> jazzy

This can be pretty long since Jazzy builds the whole workspace every time.

Once completed, you will find the generated docs in `docs/swift/`.
