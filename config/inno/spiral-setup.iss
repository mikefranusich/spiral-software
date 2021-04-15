; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Spiral"
#define MyAppVersion "8.2.0"
#define MyAppPublisher "SpiralGen, Inc."
#define MyAppURL "https://www.spiralgen.com"
#define MyAppExeName "spiral.bat"
#define SourcePath "..\..\"     ; script is expected in config\inno off root
#define MyIconFileName "spiral-logo2.ico"
#define MyUseICCFlag "UseICC :="
#define MyUseGCCFlag "UseGCC :="
#define MyUseLLVMFlag "UseLLVM :="
#define MyProfilerCompiler "set PATH_FOR_PROFILER_COMPILER="


[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{346C64AF-DF79-4187-9B09-B945BCA050C1}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=no
AllowRootDirectory=no
AlwaysShowDirOnReadyPage=yes
AlwaysShowGroupOnReadyPage=yes
LicenseFile={#SourcePath}\LICENSE
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
;; PrivilegesRequiredOverridesAllowed=dialog
OutputDir={#SourcePath}\build\inno-output
OutputBaseFilename=spiral-setup
SetupIconFile={#SourcePath}\spiral-logo2.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
WizardSizePercent=130
ChangesEnvironment=true
DisableWelcomePage=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: desktopicon; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";
Name: modifypath; Description: Add application directory to your environmental path (required to run SPIRAL from cmd window);
Name: quicklaunchicon; Description: "Create a Quick Launch icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Dirs]
Name: {code:GetDataOutputDir}; Flags: uninsneveruninstall

[Files]
Source: "{#SourcePath}\spiral.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\_spiral_win.g"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\{#MyIconFileName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\gap\bin\*"; DestDir: "{app}\gap\bin"; Flags: ignoreversion recursesubdirs createallsubdirs
;; Source: "{#SourcePath}\gap\doc\*"; DestDir: "{app}\gap\doc"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\gap\grp\*"; DestDir: "{app}\gap\grp"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\gap\lib\*"; DestDir: "{app}\gap\lib"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\namespaces\*"; DestDir: "{app}\namespaces"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\profiler\*"; Excludes: "\targets*,\tempdirs*"; DestDir: "{app}\profiler"; Flags: ignoreversion recursesubdirs createallsubdirs
;; {userappdata} ==> ~/Appdata/Roaming
;; {localappdata} ==> ~/AppData/Local
Source: "{#SourcePath}\profiler\targets\*"; DestDir: "{code:GetDataOutputDir}\profiler\targets"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\tests\*"; DestDir: "{app}\tests"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "{#SourcePath}\config\inno\installer-readme.md"; DestDir: "{app}"; Flags: isreadme

[Registry]
Root: HKA; Subkey: "Environment"; ValueType:string; ValueName: "SPIRAL_PROFILER_WORKDIR_PATH"; ValueData: "{code:GetDataOutputDir}\profiler"; Flags: preservestringtype uninsdeletevalue
Root: HKA; Subkey: "Software\SpiralGen"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\SpiralGen\{#MyAppName}"; ValueType: string; ValueName: "DataOutputsFolder"; ValueData: "{code:GetDataOutputDir}"; Flags: uninsdeletevalue;
Root: HKA; Subkey: "Software\SpiralGen\{#MyAppName}"; ValueType: string; ValueName: "VSCompilerName"; ValueData: "{code:GetCCompilerName}"; Flags: uninsdeletevalue;
Root: HKA; Subkey: "Software\SpiralGen\{#MyAppName}"; ValueType: string; ValueName: "VSDevEnvScript"; ValueData: "{code:GetCompilerMsvc}"; Flags: uninsdeletevalue;
Root: HKA; Subkey: "Software\SpiralGen\{#MyAppName}"; ValueType: string; ValueName: "LlvmClangCompiler"; ValueData: "{code:GetCompilerLlvm}"; Flags: uninsdeletevalue;
Root: HKA; Subkey: "Software\SpiralGen\{#MyAppName}"; ValueType: string; ValueName: "GnuGccCompiler"; ValueData: "{code:GetCompilerGcc}"; Flags: uninsdeletevalue;
Root: HKA; Subkey: "Software\SpiralGen\{#MyAppName}"; ValueType: string; ValueName: "IntelIclCompiler"; ValueData: "{code:GetCompilerIntel}"; Flags: uninsdeletevalue;

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyIconFileName}"; WorkingDir: "{code:GetDataOutputDir}";
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\{#MyIconFileName}";
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyIconFileName}"; WorkingDir: "{code:GetDataOutputDir}"; Tasks: desktopicon
Name: "{autoappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyIconFileName}"; WorkingDir: "{code:GetDataOutputDir}"; Tasks: quicklaunchicon;

[Code]

var
    PrevInstallPage:		TOutputMsgWizardPage;
    DataDirPage:		TInputDirWizardPage;
    CompilerPage: 		TInputOptionWizardPage;
    VSSelectPage: 		TInputFileWizardPage;
    LlvmSelectPage: 		TInputFileWizardPage;
    GccSelectPage: 		TInputFileWizardPage;
    IntelSelectPage: 		TInputFileWizardPage;
    SelectedCompilerPath: 	String;
    SelectedTargetPath:	  	String;
    RemPrevInstallOnceTime:	Integer;

const
    ModPathName = 'modifypath';
    ModPathType = 'user';

function ModPathDir(): TArrayOfString;
begin
    setArrayLength(Result, 1)
    Result[0] := ExpandConstant('{app}');
//    Result[1] := SelectedCompilerPath;

    // if uninstalling, won't have the compiler pages -- skip
    // if IsUninstaller() = false then 
    // begin
    //     any unique actions for setup or uninstaller (reverse logic of test above)
    // end;

end;

procedure InitializeWizard();
var
    strtemp: String;
begin
    // Create pages to collect:
    //     Data Outputs directory
    //	   Default compiler (and target) selection
    //	   Pages, selectively show/hidden to get compiler path info

    // Create a dummy Message screen to follow after "user info".  Will not
    // actually display screen (i.e., will always skip it); however, if a prior
    // installation was found will throw up a MsgBox to get a Yes/No from user to
    // remove the earlier version. 
    Log('wpInfoBefore page ID = ' + IntToStr(wpinfoBefore));
    PrevInstallPage := CreateOutputMsgPage(wpInfoBefore, 
    	'Checking for a prior installation',
	'Please read the following message and respond',
	'If prior install found pop a MsgBox to get Yes/No to remove it and this screen will always be skipped');
    Log('PrevInstallPage.ID = ' + IntToStr(PrevInstallPage.ID));

    Log('wpSelectDir page ID = ' + IntToStr(wpSelectDir));
    DataDirPage := CreateInputDirPage(wpSelectDir,
    	'Select Spiral Outputs Data Location',
    	'Where do you want Spiral to place generated files?',
        'Select the folder in which Spiral should place generated files;'#13#10#13#10 +
        'To continue, click Next.  If you would like to select a different folder, click Browse.',
        False, '');
    DataDirPage.Add('');
    Log('DataDirPage.ID = ' + IntToStr(DataDirPage.ID));

    // Set default value

    strtemp := ExpandConstant('{autoappdata}\{#MyAppName}');
    DataDirPage.Values[0] := GetPreviousData('DataOutputsFolder', strtemp);
    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'VSCompilerName', strtemp);

    // Compiler (and target) selection

    CompilerPage := CreateInputOptionPage(DataDirPage.ID,
	'Select the Compiler you wish to use:'#13#10,
	'Default Compiler: ' + strtemp,
	'Supported target/compilers; To continue, click Next.',
	True, False);
    CompilerPage.add('Microsoft Visual Studio');
    CompilerPage.add('LLVM');
    CompilerPage.add('GCC');
    CompilerPage.add('Intel Studio');
    CompilerPage.Values[0] := True;
    Log('CompilerPage.ID = ' + IntToStr(CompilerPage.ID));

    // Set default values

    case GetPreviousData('CompilerSelected', '') of
	'microsoft': CompilerPage.SelectedValueIndex := 0;
	'llvm':      CompilerPage.SelectedValueIndex := 1;
	'gcc':	     CompilerPage.SelectedValueIndex := 2;
	'intel':     CompilerPage.SelectedValueIndex := 3;
    else
	CompilerPage.SelectedValueIndex := 0;
    end;

    // Compiler environment/path selection
 
    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'VSDevEnvScript', strtemp);
    VSSelectPage := CreateInputFilePage(CompilerPage.ID,
	'Location of Selected Compiler',
	'Visual Studio Compiler location:'#13#10 + '    ' + strtemp + ' '#13#10,
	'Change this only if you have a different version also installed;'#13#10 +
	'To continue, click Next.');
    VSSelectPage.add('Environment Script:', 'Batch files|*.bat|All files|*.*', '.bat');
    VSSelectPage.Values[0] := GetpreviousData('GetCompilerMsvc', strtemp);
    Log('VSSelectPage.ID = ' + IntToStr(VSSelectPage.ID));

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'LlvmClangCompiler', strtemp);
    LlvmSelectPage := CreateInputFilePage(CompilerPage.ID,
	'Location of Selected Compiler',
	'LLVM Compiler location (clang.exe):'#13#10 + '    ' + strtemp + ' '#13#10,
	'Select the compiler location;'#13#10 +
	'To continue, click Next.');
    LlvmSelectPage.add('Compiler (clang.exe):', 'Executable files|*.exe|All files|*.*', '.exe');
    LlvmSelectPage.Values[0] := GetpreviousData('GetCompilerLlvm', strtemp);
    Log('LlvmSelectPage.ID = ' + IntToStr(LlvmSelectPage.ID));

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'GnuGccCompiler', strtemp);
    GccSelectPage := CreateInputFilePage(CompilerPage.ID,
	'Location of Selected Compiler',
	'GCC Compiler location:'#13#10 + '    ' + strtemp + ' '#13#10,
	'Select the compiler location;'#13#10 +
	'To continue, click Next.');
    GccSelectPage.add('Compiler:', 'Executable files|*.exe|All files|*.*', '.exe');
    GccSelectPage.Values[0] := GetpreviousData('GetCompilerGcc', strtemp);
    Log('GccSelectPage.ID = ' + IntToStr(GccSelectPage.ID));

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'IntelIclCompiler', strtemp);
    IntelSelectPage := CreateInputFilePage(CompilerPage.ID,
	'Location of Selected Compiler',
	'Intel icl Compiler location:'#13#10 + '    ' + strtemp + ' '#13#10,
	'Select the compiler location;'#13#10 +
	'To continue, click Next.');
    IntelSelectPage.add('Compiler:', 'Batch files|*.bat|All files|*.*', '.bat');
    IntelSelectPage.Values[0] := GetpreviousData('GetCompilerIntel', strtemp);
    Log('IntelSelectPage.ID = ' + IntToStr(IntelSelectPage.ID));

end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
var
    CompilerSelected: String;
begin
    // Store the settings so we can restore them next time
    SetPreviousData(PreviousDataKey, 'DataOutputsFolder', DataDirPage.Values[0]);

    case CompilerPage.SelectedValueIndex of
	0: begin
	    CompilerSelected := 'microsoft';
	    SelectedCompilerPath := ExtractFileDir(VSSelectPage.Values[0]);
	    SelectedTargetPath := 'win-x86-vcc';
	end;

	1: begin
	    CompilerSelected := 'llvm';
	    SelectedCompilerPath := ExtractFileDir(LlvmSelectPage.Values[0]);
	    SelectedTargetPath := 'win-x86-llvm';
	end;

	2: begin
	    CompilerSelected := 'gcc';
	    SelectedCompilerPath := ExtractFileDir(GccSelectPage.Values[0]);
	    SelectedTargetPath := 'win-x86-gcc';
	end;

	3: begin
	    CompilerSelected := 'intel';
	    SelectedCompilerPath := ExtractFileDir(IntelSelectPage.Values[0]);
	    SelectedTargetPath := 'win-x64-icc';
	end;
    end;

    SetPreviousData(PreviousDataKey, 'VSDevEnvScript', VSSelectPage.Values[0]);
    SetPreviousData(PreviousDataKey, 'LlvmClangCompiler', LlvmSelectPage.Values[0]);
    SetPreviousData(PreviousDataKey, 'GnuGccCompiler', GccSelectPage.Values[0]);
    SetPreviousData(PreviousDataKey, 'IntelIclCompiler', IntelSelectPage.Values[0]);

end;

function GetDataOutputDir(Param: String): String;
begin
    // Return the selected Data Output Directory
    Result := DataDirPage.Values[0];
end;

function GetCCompilerName(Param: String): String;
begin
    // Return the selected Compiler Name string 
    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'VSCompilerName', Result);
end;

function GetCompilerMsvc(Param: String): String;
var
    regValue: String;
begin
    // Return the Compiler Environment Script for MSVC

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'VSDevEnvScript', regValue);
    Result := GetPreviousData('VSDevEnvScript', regValue);
    Log('GetCompilerMsvc: reg value = ' + regValue + ' Last chosen = ' + Result);
end;

function GetCompilerLlvm(Param: String): String;
var
    regValue: String;
begin
    // Return the Compiler Path for LLVM

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'LlvmClangCompiler', regValue);
    Result := GetPreviousData('LlvmClangCompiler', regValue);
    Log('GetCompilerLlvm: reg value = ' + regValue + ' Last chosen = ' + Result);
end;

function GetCompilerGcc(Param: String): String;
var
    regValue: String;
begin
    // Return the Compiler Path for GCC

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'GnuGccCompiler', regValue);
    Result := GetPreviousData('GnuGccCompiler', regValue);
    Log('GetCompilerGcc: reg value = ' + regValue + ' Last chosen = ' + Result);
end;

function GetCompilerIntel(Param: String): String;
var
    regValue: String;
begin
    // Return the Compiler Path for Intel icl 

    RegQueryStringValue(HKEY_CURRENT_USER, 'Software\SpiralGen\Spiral', 'IntelIclCompiler', regValue);
    Result := GetPreviousData('IntelIclCompiler', regValue);
    Log('GetCompilerIntel: reg value = ' + regValue + ' Last chosen = ' + Result);
end;

function CreateFindCompilerBatch(): boolean;
var
    fileName: string;
    lines: TArrayofString;
    regkey: string;
    lno: Integer;
begin
    Result := true;
    fileName := ExpandConstant('{tmp}\FindCompiler.bat');
    regkey := ExpandConstant('HKCU\Software\SpiralGen\{#MyAppName}');
    SetArrayLength(lines, 40);

    lno := 0;
    lines[lno] := '@echo off';  lno := lno + 1;
    lines[lno] := 'set fcc1=';  lno := lno + 1;
    lines[lno] := 'set fcc2=';  lno := lno + 1;
    lines[lno] := 'set fcc3=';  lno := lno + 1;

    lines[lno] := 'for /f "usebackq delims=#" %%a in (`"C:\Program Files (x86)\Microsoft ' +
    	       	  'Visual Studio\Installer\vswhere" -latest -property displayName`) ' +
		  'do set fcc1=%%a';   lno := lno + 1;
    lines[lno] := 'for /f "usebackq delims=#" %%a in (`"C:\Program Files (x86)\Microsoft ' +
    	       	  'Visual Studio\Installer\vswhere" -latest -property catalog_productDisplayVersion`) ' +
		  'do set fcc2=%%a';   lno := lno + 1;
    lines[lno] := 'for /f "usebackq delims=#" %%a in (`"C:\Program Files (x86)\Microsoft ' +
    	       	  'Visual Studio\Installer\vswhere" -latest -property installationPath`) ' +
		  'do set fcc3=%%a\Common7\Tools\VsDevCmd.bat';   lno := lno + 1;

    lines[lno] := 'if "%fcc1%" == "" (';   lno := lno + 1;
    lines[lno] := '    reg add ' + regkey + ' /v VSCompilerName /d "Visual Studio Compiler not found" /f';   lno := lno + 1;
    lines[lno] := '    reg add ' + regkey + ' /v VSDevEnvScript /d "Script not found" /f';   lno := lno + 1;
    lines[lno] := ') else (';   lno := lno + 1;
    lines[lno] := '    set fcc1=%fcc1% and ", Version: " and %fcc2%';   lno := lno + 1;
    lines[lno] := '    reg add ' + regkey + ' /v VSCompilerName /d "%fcc1%" /f';   lno := lno + 1;
    lines[lno] := '    reg add ' + regkey + ' /v VSDevEnvScript /d "%fcc3%" /f';   lno := lno + 1;
    lines[lno] := ')';   lno := lno + 1;

    lines[lno] := 'set fcc1=';   lno := lno + 1;
    lines[lno] := 'for /f "usebackq delims=#" %%a in (`where iclvars`) do set fcc1=%%a';   lno := lno + 1;
    lines[lno] := 'if "%fcc1%" == "" (';   lno := lno + 1;
    lines[lno] := '    reg add HKCU\Software\SpiralGen\Spiral /v IntelIclCompiler /d "Intel icl not found" /f';   lno := lno + 1;
    lines[lno] := ') else (';   lno := lno + 1;
    lines[lno] := '    reg add HKCU\Software\SpiralGen\Spiral /v IntelIclCompiler /d "%fcc1%" /f';   lno := lno + 1;
    lines[lno] := ')';   lno := lno + 1;

    lines[lno] := 'set fcc1=';   lno := lno + 1;
    lines[lno] := 'for /f "usebackq delims=#" %%a in (`where clang`) do set fcc1=%%a';   lno := lno + 1;
    lines[lno] := 'if "%fcc1%" == "" (';   lno := lno + 1;
    lines[lno] := '    reg add HKCU\Software\SpiralGen\Spiral /v LlvmClangCompiler /d "Clang (LLVM) not found" /f'   lno := lno + 1;
    lines[lno] := ') else (';   lno := lno + 1;
    lines[lno] := '    reg add HKCU\Software\SpiralGen\Spiral /v LlvmClangCompiler /d "%fcc1%" /f';   lno := lno + 1;
    lines[lno] := ')';   lno := lno + 1;

    lines[lno] := 'set fcc1=';   lno := lno + 1;
    lines[lno] := 'for /f "usebackq delims=#" %%a in (`where gcc`) do set fcc1=%%a';   lno := lno + 1;
    lines[lno] := 'if "%fcc1%" == "" (';   lno := lno + 1;
    lines[lno] := '    reg add HKCU\Software\SpiralGen\Spiral /v GnuGccCompiler /d "GNU gcc not found" /f';   lno := lno + 1;
    lines[lno] := ') else (';   lno := lno + 1;
    lines[lno] := '    reg add HKCU\Software\SpiralGen\Spiral /v GnuGccCompiler /d "%fcc1%" /f';   lno := lno + 1;
    lines[lno] := ')';   lno := lno + 1;

    Result := SaveStringsToFile(fileName, lines, true);
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo,
  	 		 MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
    CompilerSelected:	String;
    strtemp: 		String;
begin
    // Fill the 'Ready Memo' with the normal settings and the custom settings 
    Result := '';

    if MemoUserInfoInfo <> '' then begin
        Result := MemoUserInfoInfo + Newline + NewLine;
    end;

    if MemoDirInfo <> '' then begin
        Result := Result + MemoDirInfo + NewLine + NewLine;
    end;

    Result := Result + 'Spiral Outputs Data Location:' + NewLine;
    Result := Result + Space + GetDataOutputDir(Result) + NewLine + NewLine;

    case CompilerPage.SelectedValueIndex of
	0: begin
	    CompilerSelected := 'Microsoft Visual Studio';
	    strtemp := ExtractFileDir(VSSelectPage.Values[0]);
	    Log('UpdateReadyMemo: Dir extracted from VsSelectPage = ' + strtemp);
	end;

	1: begin
	    CompilerSelected := 'LLVM';
	    strtemp := ExtractFileDir(LlvmSelectPage.Values[0]);
	    Log('UpdateReadyMemo: Dir extracted from LlvmSelectPage = ' + strtemp);
	end;

	2: begin
	    CompilerSelected := 'GCC';
	    strtemp := ExtractFileDir(GccSelectPage.Values[0]);
	    Log('UpdateReadyMemo: Dir extracted from GccSelectPage = ' + strtemp);
	end;

	3: begin
	    CompilerSelected := 'Intel Studio';
	    strtemp := ExtractFileDir(IntelSelectPage.Values[0]);
	    Log('UpdateReadyMemo: Dir extracted from IntelSelectPage = ' + strtemp);
	end;
    end;

    Result := Result + 'Compiler to Use:' + NewLine;
    Result := Result + Space + CompilerSelected + NewLine;
    Result := Result + Space + Space + '[Path:] ' + strtemp + NewLine + NewLine;

    if MemoGroupInfo <> '' then begin
        Result := Result + MemoGroupInfo + NewLine + NewLine;
    end;

    if MemoTasksInfo <> '' then begin
        Result := Result + MemoTasksInfo + NewLine + NewLine;
    end;

////////
    //  Result := Result + 'all memo lines:' + NewLine;
    //  Result := Result + 'MemoUserInfoInfo:' + Space + MemoUserInfoInfo + NewLine;
    //  Result := Result + 'MemoDirInfo:' + Space + MemoDirInfo + NewLine;
    //  Result := Result + 'MemoTypeInfo:' + Space + MemoTypeInfo + NewLine;
    //  Result := Result + 'MemoComponentsInfo:' + Space + MemoComponentsInfo + NewLine;
    //  Result := Result + 'MemoGroupInfo:' + Space + MemoGroupInfo + NewLine;
    //  Result := Result + 'MemoTasksInfo:' + Space + MemoTasksInfo + NewLine;
end;

#include "modpath.iss"

function ReplaceValue(const filename, tagname, tagvalue: string): Boolean;
var
    I: Integer;
    Line: string;
    TagPos: Integer;
    FileLines: TStringList;
begin
    Result := False;

    FileLines := TStringList.Create;
    try
	FileLines.LoadFromFile(filename);
    	for I := 0 to FileLines.Count - 1 do
    	begin
	    Line := FileLines[I];
      	    TagPos := Pos(tagname, Line);
      	    if TagPos > 0 then
      	    begin
		Result := True;
        	Delete(Line, TagPos + Length(tagname), MaxInt);
        	Line := Line + tagvalue;
        	FileLines[I] := Line;
        	FileLines.SaveToFile(filename);
        	Break;
      	    end;
    	end;
    finally
	FileLines.Free;
    end;
end;

<event ('CurStepChanged')>
procedure CurStepChanged2(CurStep: TSetupStep);
var
    filename:	String;
    tagstring:	String;
    tagvalue:	String;
    dummy:	String;
begin
    if CurStep = ssPostInstall then
    begin
	// Install is complete (i.e., all files in place) -- do file mods now
	// Replace UseXXX compiler flag lines in _spiral_win.g

	Log('CurStepChanged2: Replace UseXXX compiler flag lines in _spiral_win.g');
	filename := ExpandConstant('{app}\_spiral_win.g');
	StringChangeEx(filename, '\', '\\', True);

	tagstring := ExpandConstant('{#MyUseICCFlag}');
	if CompilerPage.SelectedValueIndex = 3 then
	    tagvalue := ' true;' 
	else 
	    tagvalue := ' false;';

	if not ReplaceValue(filename, tagstring, tagvalue) then
	    MsgBox('Could not update "Use Intel Compiler" flag in _spiral_win.g', mbError, MB_OK)
	else
	    Log('Set ' + tagstring + tagvalue);

	tagstring := ExpandConstant('{#MyUseGCCFlag}');
	if CompilerPage.SelectedValueIndex = 2 then
	    tagvalue := ' true;' 
	else 
	    tagvalue := ' false;';

	if not ReplaceValue(filename, tagstring, tagvalue) then
	    MsgBox('Could not update "Use GCC Compiler" flag in _spiral_win.g', mbError, MB_OK)
	else
	    Log('Set ' + tagstring + tagvalue);

	tagstring := ExpandConstant('{#MyUseLLVMFlag}');
	if CompilerPage.SelectedValueIndex = 1 then
	    tagvalue := ' true;' 
	else 
	    tagvalue := ' false;';

	if not ReplaceValue(filename, tagstring, tagvalue) then
	    MsgBox('Could not update "Use LLVM Compiler" flag in _spiral_win.g', mbError, MB_OK)
	else
	    Log('Set ' + tagstring + tagvalue);

	if SelectedTargetPath <> 'win-x86-vcc' then
	begin
	    // Update the PATH_FOR_PROFILER_COMPILER value in time.cmd & matrix.cmd of the selected target

	    filename := GetDataOutputDir(dummy) + '\profiler\targets\' + SelectedTargetPath + '\matrix.cmd';
	    StringChangeEx(filename, '\', '\\', True);
	    tagstring := ExpandConstant('{#MyProfilerCompiler}');
	    tagvalue := SelectedCompilerPath;

	    if not ReplaceValue(filename, tagstring, tagvalue) then
	        begin
		    dummy := 'Could not update "' + ExpandConstant('{#MyProfilerCompiler}') +
		      	     '" value in ' + filename;
	    	    MsgBox(dummy, mbError, MB_OK)
	    	end
	    else
		Log('In: ' + filename + ': Set ' + tagstring + tagvalue);

	    filename := GetDataOutputDir(dummy) + '\profiler\targets\' + SelectedTargetPath + '\time.cmd';
	    StringChangeEx(filename, '\', '\\', True);

	    if not ReplaceValue(filename, tagstring, tagvalue) then
	        begin
		    dummy := 'Could not update "' + ExpandConstant('{#MyProfilerCompiler}') +
		      	     '" value in ' + filename;
		    MsgBox(dummy, mbError, MB_OK)
		end
	    else
		Log('In: ' + filename + ': Set ' + tagstring + tagvalue);
	end;
    end;
end;


//
//  Remove a previous install before installing the latest version
//

function GetUninstallString(): String;
var
    sUnInstPath: String;
    sUnInstallString: String;
begin
    sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
    sUnInstallString := '';
    if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
       RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
    Result := sUnInstallString;
end;


//  Get the uninstall command

function IsUpgrade(): Boolean;
begin
    Result := (GetUninstallString() <> '');

    if RemPrevInstallOnceTime > 0 then
	RemPrevInstallOnceTime := 0
    else
    	Result := False;

end;

//  Run uninstall command

function UnInstallOldVersion(): Integer;
var
    sUnInstallString: String;
    iResultCode: Integer;
begin
    // Return Values:
    // 1 - uninstall string is empty
    // 2 - error executing the UnInstallString
    // 3 - successfully executed the UnInstallString

    // default return value
    Result := 0;

    // get the uninstall string of the old app
    sUnInstallString := GetUninstallString();
    if sUnInstallString <> '' then 
    begin
        sUnInstallString := RemoveQuotes(sUnInstallString);
    	if Exec(sUnInstallString, '/SILENT /NORESTART /SUPPRESSMSGBOXES','', 
	        SW_HIDE, ewWaitUntilTerminated, iResultCode) then
            Result := 3
	else
	    Result := 2;
    end 
    else
	Result := 1;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
var
    V:          Integer;
    strtemp:	String;
begin
    // Skip pages that shouldn't be shown -- by default show pages
    Result := False;
    Log('ShouldSkipPage(): Page ID = ' + IntToStr(PageID));

    // PrevInstallPage is a dummy to check on prior installations
    if (PageID = PrevInstallPage.ID) then
    begin
	// Is there a prior installation, if so, offer to remove it
	if (IsUpgrade()) then
    	begin
	    // A prior version was installed; get user input on remove/leave
	    V := MsgBox('A previous version of SPIRAL was detected. Do you want to uninstall it?',
	      	 	mbInformation, MB_YESNO);
    	    if V = IDYES then
	       	UnInstallOldVersion();

	end;
	Result := True
    end;

    // Show only one of the possible compiler selected pages
    if (PageID = VSSelectPage.ID) and (CompilerPage.SelectedValueIndex <> 0) then
	Result := True
    else if (PageID = LlvmSelectPage.ID) and (CompilerPage.SelectedValueIndex <> 1) then
	Result := True
    else if (PageID = GccSelectPage.ID) and (CompilerPage.SelectedValueIndex <> 2) then
	Result := True
    else if (PageID = IntelSelectPage.ID) and (CompilerPage.SelectedValueIndex <> 3) then
	Result := True;

    if Result then strtemp := 'True' else strtemp := 'False';
    Log('ShouldSkipPage(): Result  = ' + strtemp);
end;

function InitializeSetup(): Boolean;
var
    fileName:   String;
    ResultCode: Integer;
begin
    RemPrevInstallOnceTime := 1;

    // Create and run the find compiler batch script
    CreateFindCompilerBatch();

    // Run the batch file, wait for it to terminate
    fileName := ExpandConstant('{tmp}\FindCompiler.bat');
    Result := Exec(fileName, '', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    if not Result then
    begin
	// handle failure if necessary; ResultCode contains the error code
    end;

end;

//  Check step is now ready to install ("ssInstall")

//  <event ('CurStepChanged')>
//  procedure CurStepChanged3(CurStep: TSetupStep);
//  begin
//      if (CurStep = ssInstall) then
//      begin
//  	if (IsUpgrade()) then
//      	begin
//  	    UnInstallOldVersion();
//      	end;
//      end;
//  end;


[Run]
Filename: "{cmd}"; Parameters: "/C set SPIRAL_PROFILER_WORKDIR_PATH={code:GetDataOutputDir}\profiler & ""{app}\{#MyAppExeName}"""; WorkingDir: "{code:GetDataOutputDir}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: postinstall skipifsilent unchecked

[UninstallDelete]
;; uninstall only files potentially created by running spiral...
Type: filesandordirs; Name: "{code:GetDataOutputDir}\profiler";
Type: files; Name: "{app}\.gap_history";
Type: files; Name: "{code:GetDataOutputDir}\.gap_history";

;; #expr SaveToFile(AddBackslash({#OutputDir}) + "Preprocessed.iss")
#expr SaveToFile("Preprocessed.iss")