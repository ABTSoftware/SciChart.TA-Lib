using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;

namespace SciChart.TA_Lib.Net
{
    public class NativeDllLoader
    {
        private const string MSVCP140DllName = "msvcp140.dll";

        private static volatile bool _initialized;

        private const string ResourcesX64 = ".Resources.x64.";
        private const string ResourcesX86 = ".Resources.Win32.";
        private const string LibraryName = "TALib.dll";

        public static string DependenciesPath { get; private set; }

        /// <summary>
        /// Initializes the <see cref="NativeDllLoader"/> class.
        /// </summary>
        static NativeDllLoader()
        {
            var asm = typeof(NativeDllLoader).Assembly;
            var version = "v" + asm.GetName().Version;

            DependenciesPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
                "SciChart",
                "TA-Lib",
                "Dependencies",
                version,
                Environment.Is64BitProcess ? "x64" : "x86");
        }

        public static void InitNativeLibs()
        {
            lock (typeof(NativeDllLoader))
            {
                if (_initialized) return;

                if (!NativeDllLoader.AssertVcppDependencies())
                {
                    string platform = Environment.Is64BitProcess ? "x64 and x86" : "x86";
                    throw new InvalidOperationException("TA-Lib.NET Requires the Visual C++ 2015 " + platform +
                            " Runtime to be installed on this computer. Please download and install it from https://www.microsoft.com/en-gb/download/details.aspx?id=48145");
                }

                var asm = typeof(NativeDllLoader).Assembly;

                Console.WriteLine("Writing out DLLs to " + NativeDllLoader.DependenciesPath);
                
                string resourcesString = Environment.Is64BitProcess ? ResourcesX64 : ResourcesX86;
                string nativeDllOutPath = Path.Combine(NativeDllLoader.DependenciesPath, LibraryName);
                string nativeDllResourcesPath = asm.GetName().Name + resourcesString + LibraryName;

                NativeDllLoader.LoadDllFromResource(asm, nativeDllResourcesPath, nativeDllOutPath, true); 

                _initialized = true;
            }
        }

        [DllImport("kernel32.dll")]
        internal static extern IntPtr LoadLibrary(string dllToLoad);

        /// <summary>
        /// Calls Platform Invoke LoadLibrary on a native DLL embedded as a resource in the <paramref name="asm">Assembly</paramref> passed in. 
        /// 
        /// The native DLL is written out to <paramref name="destinationPath"/> so ensure this is a directory you have permission to write to
        /// </summary>
        internal static void LoadDllFromResource(Assembly asm, string resourceString, string destinationPath, bool overwrite)
        {
            try
            {
                // TODO: always write out DLL in dev mode. For production code we might want to do this once depending on version number
                if (overwrite || !File.Exists(destinationPath))
                {
                    Directory.CreateDirectory(Path.GetDirectoryName(destinationPath));

                    WriteFileFromResource(asm, resourceString, destinationPath, true);
                }

                if (File.Exists(destinationPath))
                {
                    LoadLibrary(destinationPath);
                }
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("Failed to load file " + destinationPath + " as an unmanaged DLL", ex);
            }
        }

        internal static bool AssertVcppDependencies()
        {
            var system32Path = Environment.GetFolderPath(Environment.SpecialFolder.SystemX86);
            var system64Path = Environment.GetFolderPath(Environment.SpecialFolder.System);

            bool success = File.Exists(Path.Combine(system32Path, MSVCP140DllName));

            if (Environment.Is64BitProcess)
            {
                success &= File.Exists(Path.Combine(system64Path, MSVCP140DllName));
            }

            return success;
        }

        private static void WriteFileFromResource(Assembly asm, string resourceString, string destinationPath, bool throwOnError = true)
        {
            using (var stream = asm.GetManifestResourceStream(resourceString.Replace("-", "_")))
            {
                if (stream == null)
                {
                    if (throwOnError)
                        throw new ArgumentNullException("The manifest resource stream " + resourceString + " was not found");

                    return;
                }

                using (var br = new BinaryReader(stream))
                {
                    byte[] data = br.ReadBytes((int)stream.Length);
                    try
                    {
                        File.WriteAllBytes(destinationPath, data);
                    }
                    catch (IOException)
                    {
                        Trace.WriteLine("Unable to write to " + destinationPath + " as the file is already in use");
                    }
                }
            }
        }
    }
}
