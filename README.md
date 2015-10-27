# KAImportOrganizer
Organizes (sorts) Objective-C and Swift imports.

How to configure:

1. Build
2. Move product to somewhere you have easy access to it (or inside of your project root)
3. Create an `import_config` inside the same directory the binary is for this.

How it works:

KAImportOrganizer takes all the imports in a file, coalesces them, and then sorts them. It then removes the old import and inserts the new imports. 

## Your `import_config` file

Must be a JSON string. This defines what files to look at in what directories. For example:

```{
	"file_extensions" : [
		"h",
		"m",
		"swift"
	],
	"directories" : [
		"Classes"
	]
}```

This looks at the Classes directory for files with either a .h, .m, or .swift file extensions, in order to organize their imports.

## Limitations:

~~1. Doesn't play well with comments that intermingled with import statements.~~ - This should now be working for the most part.
1. Adds extra lines to end of imports if there were lines in between imports before sorting.

### What else needs to be done:

1. Define rules about sorting bracketed imports to always be above quation mark imports in Objective-C

