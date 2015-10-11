# KAImportOrganizer
Organizes Objective-C and Swift imports

How to configure:

1. Build
2. Move product to somewhere you have easy access to it (or inside of your project root)
3. Create an `import_config` inside the same directory the binary is for this.

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

