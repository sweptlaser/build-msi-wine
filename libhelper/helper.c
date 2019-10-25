
#define DLL_PUBLIC __declspec(dllexport)

#include <windows.h>
#include <winreg.h>
#include <stdio.h>
#include <msi.h>
#include <msiquery.h>

DLL_PUBLIC UINT GetProgramFiles(MSIHANDLE handle) {
  char longpath[PATH_MAX] = "", shortpath[PATH_MAX] = "";
  LONG size = sizeof(longpath);
  HKEY key;
  INT ret;

  ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, "SOFTWARE\\Microsoft\\Windows\\CurrentVersion", 0, KEY_QUERY_VALUE|KEY_WOW64_64KEY, &key);
  if(ret) { return ERROR_FUNCTION_FAILED; }
  ret = RegQueryValueEx(key, "ProgramFilesDir", 0, NULL, (LPBYTE)longpath, &size);
  if(ret) { return ERROR_FUNCTION_FAILED; }
  RegCloseKey(key);

  if(GetShortPathName(longpath, shortpath, size) == 0) { return ERROR_FUNCTION_FAILED; }
  return MsiSetPropertyA(handle, "ProgramFilesFolder", shortpath);
}

