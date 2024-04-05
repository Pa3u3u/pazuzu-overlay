# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Collection of fonts that are patched to include a high number of glyphs (icons)"
HOMEPAGE="https://nerdfonts.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

FONTS=(
	0xProto
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CascadiaMono
	CodeNewRoman
	ComicShannsMono
	CommitMono
	Cousine
	D2Coding
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	EnvyCodeR
	EnvyCodeR
	FantasqueSansMono
	FiraCode
	FiraMono
	GeistMono
	Gohu
	Go-Mono
	Hack
	Hasklig
	HeavyData
	Hermit
	iA-Writer
	IBMPlexMono
	Inconsolata
	InconsolataGo
	InconsolataLGC
	IntelOneMono
	IntelOneMono
	Iosevka
	IosevkaTerm
	IosevkaTermSlab
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	MartianMono
	Meslo
	Monaspace
	Monofur
	Monoid
	Mononoki
	MPlus
	+NerdFontsSymbolsOnly
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	Recursive
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	UbuntuSans
	VictorMono
	ZedMono
)

IUSE="
	${FONTS[*],,}

	otf
	+ttf
"

REQUIRED_USE="|| ( otf ttf )"

BASE_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}"

SRC_URI="
	0xproto? ( "${BASE_URI}/0xProto.tar.xz" -> "0xProto-${PV}.tar.xz" )
	3270? ( "${BASE_URI}/3270.tar.xz" -> "3270-${PV}.tar.xz" )
	agave? ( "${BASE_URI}/Agave.tar.xz" -> "Agave-${PV}.tar.xz" )
	anonymouspro? ( "${BASE_URI}/AnonymousPro.tar.xz" -> "AnonymousPro-${PV}.tar.xz" )
	arimo? ( "${BASE_URI}/Arimo.tar.xz" -> "Arimo-${PV}.tar.xz" )
	aurulentsansmono? ( "${BASE_URI}/AurulentSansMono.tar.xz" -> "AurulentSansMono-${PV}.tar.xz" )
	bigblueterminal? ( "${BASE_URI}/BigBlueTerminal.tar.xz" -> "BigBlueTerminal-${PV}.tar.xz" )
	bitstreamverasansmono? ( "${BASE_URI}/BitstreamVeraSansMono.tar.xz" -> "BitstreamVeraSansMono-${PV}.tar.xz" )
	cascadiacode? ( "${BASE_URI}/CascadiaCode.tar.xz" -> "CascadiaCode-${PV}.tar.xz" )
	cascadiamono? ( "${BASE_URI}/CascadiaMono.tar.xz" -> "CascadiaMono-${PV}.tar.xz" )
	codenewroman? ( "${BASE_URI}/CodeNewRoman.tar.xz" -> "CodeNewRoman-${PV}.tar.xz" )
	comicshannsmono? ( "${BASE_URI}/ComicShannsMono.tar.xz" -> "ComicShannsMono-${PV}.tar.xz" )
	commitmono? ( "${BASE_URI}/CommitMono.tar.xz" -> "CommitMono-${PV}.tar.xz" )
	cousine? ( "${BASE_URI}/Cousine.tar.xz" -> "Cousine-${PV}.tar.xz" )
	d2coding? ( "${BASE_URI}/D2Coding.tar.xz" -> "D2Coding-${PV}.tar.xz" )
	daddytimemono? ( "${BASE_URI}/DaddyTimeMono.tar.xz" -> "DaddyTimeMono-${PV}.tar.xz" )
	dejavusansmono? ( "${BASE_URI}/DejaVuSansMono.tar.xz" -> "DejaVuSansMono-${PV}.tar.xz" )
	droidsansmono? ( "${BASE_URI}/DroidSansMono.tar.xz" -> "DroidSansMono-${PV}.tar.xz" )
	envycoder? ( "${BASE_URI}/EnvyCodeR.tar.xz" -> "EnvyCodeR-${PV}.tar.xz" )
	envycoder? ( "${BASE_URI}/EnvyCodeR.tar.xz" -> "EnvyCodeR-${PV}.tar.xz" )
	fantasquesansmono? ( "${BASE_URI}/FantasqueSansMono.tar.xz" -> "FantasqueSansMono-${PV}.tar.xz" )
	firacode? ( "${BASE_URI}/FiraCode.tar.xz" -> "FiraCode-${PV}.tar.xz" )
	firamono? ( "${BASE_URI}/FiraMono.tar.xz" -> "FiraMono-${PV}.tar.xz" )
	geistmono? ( "${BASE_URI}/GeistMono.tar.xz" -> "GeistMono-${PV}.tar.xz" )
	gohu? ( "${BASE_URI}/Gohu.tar.xz" -> "Gohu-${PV}.tar.xz" )
	go-mono? ( "${BASE_URI}/Go-Mono.tar.xz" -> "Go-Mono-${PV}.tar.xz" )
	hack? ( "${BASE_URI}/Hack.tar.xz" -> "Hack-${PV}.tar.xz" )
	hasklig? ( "${BASE_URI}/Hasklig.tar.xz" -> "Hasklig-${PV}.tar.xz" )
	heavydata? ( "${BASE_URI}/HeavyData.tar.xz" -> "HeavyData-${PV}.tar.xz" )
	hermit? ( "${BASE_URI}/Hermit.tar.xz" -> "Hermit-${PV}.tar.xz" )
	ia-writer? ( "${BASE_URI}/iA-Writer.tar.xz" -> "iA-Writer-${PV}.tar.xz" )
	ibmplexmono? ( "${BASE_URI}/IBMPlexMono.tar.xz" -> "IBMPlexMono-${PV}.tar.xz" )
	inconsolata? ( "${BASE_URI}/Inconsolata.tar.xz" -> "Inconsolata-${PV}.tar.xz" )
	inconsolatago? ( "${BASE_URI}/InconsolataGo.tar.xz" -> "InconsolataGo-${PV}.tar.xz" )
	inconsolatalgc? ( "${BASE_URI}/InconsolataLGC.tar.xz" -> "InconsolataLGC-${PV}.tar.xz" )
	intelonemono? ( "${BASE_URI}/IntelOneMono.tar.xz" -> "IntelOneMono-${PV}.tar.xz" )
	intelonemono? ( "${BASE_URI}/IntelOneMono.tar.xz" -> "IntelOneMono-${PV}.tar.xz" )
	iosevka? ( "${BASE_URI}/Iosevka.tar.xz" -> "Iosevka-${PV}.tar.xz" )
	iosevkaterm? ( "${BASE_URI}/IosevkaTerm.tar.xz" -> "IosevkaTerm-${PV}.tar.xz" )
	iosevkatermslab? ( "${BASE_URI}/IosevkaTermSlab.tar.xz" -> "IosevkaTermSlab-${PV}.tar.xz" )
	jetbrainsmono? ( "${BASE_URI}/JetBrainsMono.tar.xz" -> "JetBrainsMono-${PV}.tar.xz" )
	lekton? ( "${BASE_URI}/Lekton.tar.xz" -> "Lekton-${PV}.tar.xz" )
	liberationmono? ( "${BASE_URI}/LiberationMono.tar.xz" -> "LiberationMono-${PV}.tar.xz" )
	lilex? ( "${BASE_URI}/Lilex.tar.xz" -> "Lilex-${PV}.tar.xz" )
	martianmono? ( "${BASE_URI}/MartianMono.tar.xz" -> "MartianMono-${PV}.tar.xz" )
	meslo? ( "${BASE_URI}/Meslo.tar.xz" -> "Meslo-${PV}.tar.xz" )
	monaspace? ( "${BASE_URI}/Monaspace.tar.xz" -> "Monaspace-${PV}.tar.xz" )
	monofur? ( "${BASE_URI}/Monofur.tar.xz" -> "Monofur-${PV}.tar.xz" )
	monoid? ( "${BASE_URI}/Monoid.tar.xz" -> "Monoid-${PV}.tar.xz" )
	mononoki? ( "${BASE_URI}/Mononoki.tar.xz" -> "Mononoki-${PV}.tar.xz" )
	mplus? ( "${BASE_URI}/MPlus.tar.xz" -> "MPlus-${PV}.tar.xz" )
	nerdfontssymbolsonly? ( "${BASE_URI}/NerdFontsSymbolsOnly.tar.xz" -> "NerdFontsSymbolsOnly-${PV}.tar.xz" )
	noto? ( "${BASE_URI}/Noto.tar.xz" -> "Noto-${PV}.tar.xz" )
	opendyslexic? ( "${BASE_URI}/OpenDyslexic.tar.xz" -> "OpenDyslexic-${PV}.tar.xz" )
	overpass? ( "${BASE_URI}/Overpass.tar.xz" -> "Overpass-${PV}.tar.xz" )
	profont? ( "${BASE_URI}/ProFont.tar.xz" -> "ProFont-${PV}.tar.xz" )
	proggyclean? ( "${BASE_URI}/ProggyClean.tar.xz" -> "ProggyClean-${PV}.tar.xz" )
	recursive? ( "${BASE_URI}/Recursive.tar.xz" -> "Recursive-${PV}.tar.xz" )
	robotomono? ( "${BASE_URI}/RobotoMono.tar.xz" -> "RobotoMono-${PV}.tar.xz" )
	sharetechmono? ( "${BASE_URI}/ShareTechMono.tar.xz" -> "ShareTechMono-${PV}.tar.xz" )
	sourcecodepro? ( "${BASE_URI}/SourceCodePro.tar.xz" -> "SourceCodePro-${PV}.tar.xz" )
	spacemono? ( "${BASE_URI}/SpaceMono.tar.xz" -> "SpaceMono-${PV}.tar.xz" )
	terminus? ( "${BASE_URI}/Terminus.tar.xz" -> "Terminus-${PV}.tar.xz" )
	tinos? ( "${BASE_URI}/Tinos.tar.xz" -> "Tinos-${PV}.tar.xz" )
	ubuntu? ( "${BASE_URI}/Ubuntu.tar.xz" -> "Ubuntu-${PV}.tar.xz" )
	ubuntumono? ( "${BASE_URI}/UbuntuMono.tar.xz" -> "UbuntuMono-${PV}.tar.xz" )
	ubuntusans? ( "${BASE_URI}/UbuntuSans.tar.xz" -> "UbuntuSans-${PV}.tar.xz" )
	victormono? ( "${BASE_URI}/VictorMono.tar.xz" -> "VictorMono-${PV}.tar.xz" )
	zedmono? ( "${BASE_URI}/ZedMono.tar.xz" -> "ZedMono-${PV}.tar.xz" )
"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/xz-utils"

src_unpack() {
	mkdir -p "$S"

	for archive in $A; do
		tar -Jx -C "$S" -f "$DISTDIR/$archive"
	done
}

src_install() {
	find "$S" -iname 'readme.md' -delete

	suffixes=()
	for suffix in otf ttf; do
		if ! use "$suffix"; then
			continue
		fi

		count=$(find "$S" -regex ".*\.$suffix\$" | wc -l)
		if [ "$count" -gt 0 ]; then
			elog "Installing $count $suffix fonts"
			suffixes+=($suffix)
		else
			ewarn "No $suffix font found"
		fi
	done

	FONT_SUFFIX="${suffixes[@]}"
	font_src_install
}
