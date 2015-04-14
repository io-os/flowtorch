/// <reference path="../definitions/node.d.ts" />
/// <reference path="../definitions/typescript.d.ts" />

import ts = require("typescript");

declare var require;

var fs:typeof fs = require('fs');
var path:typeof path = require('path');

// this ends up being the graph editors
// primary resource..
export class BlockInfo {
  public name:string;
  public vars:Array<string>;
  public funcs:Array<string>;
  
  public BlockInfo(obj) {
    if (obj) {
      this.name = obj.name || '';
      this.vars = obj.vars || '';
      this.funcs = obj.funcs || '';
    }
    else
    {
      this.name = '';
      this.vars = [];
      this.funcs = [];
    }
  }
}

// various block types should be auto-generated calls to functions
// encapsulated within a block that creates itself and wraps
// definitions from the typescript compiler to flow-language
// compatible Blocks. All blocks are classes with data to
// move in and out both directions for each property.

// Start Block -> Action

export class Compiler {
  
  public result: ts.EmitResult;
  public checker: ts.TypeChecker;
  public program: ts.Program;
  public outputs;
  public errors;
  
  public blockTypes;
  
  public generateBlockMapping(node:ts.Node) {
    this.program.getSourceFiles().map(x => {
      if (!x || !x.symbol || !x.symbol.exports) return;
      
      var keys = Object.keys(x.symbol.exports);
      var exports = keys.map(key => x.symbol.exports[key]);
      
      console.dir(exports);
      
      // we are only looking for those classes that extend block types now.
      exports = exports.filter((x:any) => x.valueDeclaration && x.valueDeclaration.heritageClauses && x.valueDeclaration.heritageClauses.length != 0);
      //exports = exports.filter((x:any) => x.types && x.types.length != 0);
      
      console.dir(exports);
      
      this.blockTypes = [];
      
      // capture the custom-built blocks themselves
      exports.forEach((x:any) => {
        var decl = x.valueDeclaration;
        if (!decl.heritageClauses || !decl.heritageClauses[0].types || decl.heritageClauses[0].types.length == 0) return;
        
        var inherits = decl.heritageClauses[0].types.map((y:any) => y.typeName.text);
        console.dir(inherits);
        
        for (var i=0;i<inherits.length;i++) {
          if (inherits[i].indexOf("Block") != -1) {
            if (this.blockTypes.indexOf(x.name) == -1) {
              
              x.blockInfo = new BlockInfo();
              x.blockInfo.name = x.name;
              x.blockInfo.vars = [];
              x.blockInfo.funcs = [];
              
              if (x.members && Object.keys(x.members).length > 0) {
                Object.keys(x.members).forEach((name) => {
                  var typeName = name, valueName = null;
                  var y = x.members[name];
                  
                  if (y.valueDeclaration.type && (valueName = y.valueDeclaration.type.typeName.text)) {
                    x.blockInfo.vars.push({ "name": typeName, "type": valueName });
                  }
                });
              }
              
              this.blockTypes.push(x);
            }
          }
        }
      });
      
      return this.blockTypes;
    });
  }
  
  // from site
  public static transform(contents: string, libSource: string, compilerOptions: ts.CompilerOptions = {}) {
      // Generated outputs
      var outputs = [];
      // Create a compilerHost object to allow the compiler to read and write files
      var compilerHost:ts.CompilerHost = {
          getSourceFile: function (filename, languageVersion) {
              if (filename === "file.ts")
                  return ts.createSourceFile(filename, contents, compilerOptions.target, '0.0.0', false);
              if (filename === "lib.d.ts")
                  return ts.createSourceFile(filename, libSource, compilerOptions.target, '0.0.0', false);
                  
              return ts.createSourceFile(filename, contents, compilerOptions.target, '0.0.0', false);
          },
          writeFile: function (name, text, writeByteOrderMark) {
              outputs.push({ name: name, text: text, writeByteOrderMark: writeByteOrderMark });
          },
          getDefaultLibFilename: function () { return "lib.d.ts"; },
          useCaseSensitiveFileNames: function () { return false; },
          getCanonicalFileName: function (filename) { return filename; },
          getCurrentDirectory: function () { return ""; },
          getNewLine: function () { return "\n"; }
      };
      // Create a program from inputs
      var program = ts.createProgram(["file.ts"], compilerOptions, compilerHost);
      
      // Query for early errors
      var errors = program.getGlobalDiagnostics()
      var checker = program.getTypeChecker(true);
      var emitResult = checker.emitFiles()
      
      var result = new Compiler();
      
      result.result = emitResult;
      result.errors = errors.map(function (e) { return e.file.filename + "(" + e.start + "): " + e.messageText; });
      result.outputs = outputs;
      result.checker = checker;
      result.program = program;
      
      console.log(outputs[0].text);
      return result;
  }
  
  public static create(contents: string, compilerOptions: ts.CompilerOptions = {}) {
      // Generated outputs
      var outputs = [];
      // Create a compilerHost object to allow the compiler to read and write files
      var compilerHost:ts.CompilerHost = {
          getSourceFile: function (filename, languageVersion) {
              if (filename === "file.ts")
                  return ts.createSourceFile(filename, contents, compilerOptions.target, '0.0.0', false);
                  
              return ts.createSourceFile(filename, contents, compilerOptions.target, '0.0.0', false);
          },
          writeFile: function (name, text, writeByteOrderMark) {
              outputs.push({ name: name, text: text, writeByteOrderMark: writeByteOrderMark });
          },
          getDefaultLibFilename: function () { return "lib.d.ts"; },
          useCaseSensitiveFileNames: function () { return false; },
          getCanonicalFileName: function (filename) { return filename; },
          getCurrentDirectory: function () { return ""; },
          getNewLine: function () { return "\n"; }
      };
      // Create a program from inputs
      var program = ts.createProgram(["file.ts"], compilerOptions, compilerHost);
      var newFile:ts.SourceFile = ts.createSourceFile('ha.ts', '', compilerOptions.target, '0.0.0', false);
      
      // Query for early errors
      var errors = program.getGlobalDiagnostics();
      var checker = program.getTypeChecker(true);
      var emitResult = checker.emitFiles();
      
      var result = new Compiler();
      
      result.result = emitResult;
      result.errors = errors.map(function (e) { return e.file.filename + "(" + e.start + "): " + e.messageText; });
      result.outputs = outputs;
      result.checker = checker;
      result.program = program;
      
      //console.log(outputs[0].text);
      return result;
  }
  
  
}

// Calling our transform function using a simple TypeScript variable declarations, 
// and loading the default library like:
var source = "var x: number  = 'string'";
var libSource = fs.readFileSync(path.join(path.dirname(require.resolve('typescript')), 'lib.d.ts')).toString();
var result = Compiler.create(source, libSource);

console.log('output from compiler is: ')
console.log(JSON.stringify(result));