@ECHO OFF
SET DXC="F:\UnrealEG\UE_5.2\Engine\Binaries\ThirdParty\ShaderConductor\Win64\dxc.exe"
IF NOT EXIST %DXC% (
	ECHO Couldn't find dxc.exe under "F:\UnrealEG\UE_5.2\Engine\Binaries\ThirdParty\ShaderConductor\Win64"
	GOTO :END
)
%DXC% /auto-binding-space 0 /Zpr /O3 -Wno-parentheses-equality -disable-lifetime-markers /T ps_6_6 /E MainPS /Fc BasePassPixelShader.d3dasm /Fo BasePassPixelShader.dxil BasePassPixelShader.usf
:END
PAUSE
