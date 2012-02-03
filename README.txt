Allrite time to take shit to the next level.

So what I want to do is create a script called make that uses a plist file to create a static library.The name of the plist file
is additions.plist and it will be at the root of the repository.

Now there are two ways to make the required static library.The first and obvious way is to make it using gcc manually.
The second way and the method I like is to use an xcode project to build it.

All the user has to do then is to add the Xcode project to the project dependencies and BAM!!... all the awesome categories and 
classes and categories he wants to use gets built in to a static library....In fact with Xcode 4.2 he can go into the files and change shit when he feels like.The Additions xcode project will also run a script that will copy all the required header imports into a customized file for each type of class.All the imports for the NSObject categories will get copied into the NSObjectAdditions file.Some people like to call something like this the height of awesomeness.LOL.

So from the users point of view.All he does is
 
a) Adds the category he wants to the plist file.

b) Adds an import to his source file either with #import<Additions/NSObjectAdditions.h> or with #import<Additions+NSObject+Blah.h>
   and then he can use that method on his source file.

Also care should be take so that Xcode is able to autocomplete methods for the user.For that I recommend that all the headers being used along with the custom created headers are copied into the headers directory.The user can then just add the Headers folder in his header search paths and BAM!.

Some people might say something like "Dude why are you doing something like this.Why dont you just compile everything into a single static library".For that all I can say is "Dude check out https://developer.apple.com/library/mac/#qa/qa2006/qa1490.html The folks at apple are saying that the -ObjC flag will force the linker to load all classes and categories.Now lets say the additions project improves to a thousand categories .Is it a good idea to put all those categories into you binary?"

So when am I going to make this awesome script and Xcode project.Well definitely not today.Today I am just ideating.

Maybe sometime next week.Shouldnt take too long anyways.

