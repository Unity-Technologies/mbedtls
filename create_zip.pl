use autodie qw(:all);
use File::Path qw( rmtree );
use POSIX;

my $zExe = "7z";

if ($^O eq "MSWin32")
{
	$zExe = "External\\7z\\win64\\7za.exe";
}
elsif ($^O eq "darwin")
{
	my $hostArch = (POSIX::uname)[4];
	if ($hostArch eq "arm64")
	{
		$zExe = "External/7z/osx-arm64/7za";
	}
	else
	{
		$zExe = "External/7z/osx/7za";
	}
}

system("git show --quiet HEAD > gitrevision.txt");

rmtree("build");
mkdir("build");

print("Using $zExe\n");
system("$zExe a -t7z -m0=lzma2 -x!.git -x!External -x!create_zip.pl -x!build build/builds.7z");

