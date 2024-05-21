Name:       com.lmaxyz.SlintAuroraExample
Summary:    Slint Application Example
Version:    0.1
Release:    1
Group:      Qt/Qt
License:    BSD-3-Clause
URL:        https://community.omprussia.ru/open-source
Source0:    %{name}-%{version}.tar.bz2
Source1:    %{name}.desktop
Source2:    icons

%description
Slint Application Example.

%prep
%autosetup

%build

%install
rm -rf %{buildroot}
install -d %{buildroot}%{_datadir}/%{name}
install -Dm 755 %{name} -t %{buildroot}%{_bindir}

desktop-file-install \
  --dir %{buildroot}%{_datadir}/applications \
   %{_sourcedir}/../%{name}.desktop

install -Dm 644 %{SOURCE2}/86x86/%{name}.png -t %{buildroot}%{_datadir}/icons/hicolor/86x86/apps
install -Dm 644 %{SOURCE2}/108x108/%{name}.png -t %{buildroot}%{_datadir}/icons/hicolor/108x108/apps
install -Dm 644 %{SOURCE2}/128x128/%{name}.png -t %{buildroot}%{_datadir}/icons/hicolor/128x128/apps
install -Dm 644 %{SOURCE2}/172x172/%{name}.png -t %{buildroot}%{_datadir}/icons/hicolor/172x172/apps
mkdir -p %{buildroot}%{_datadir}/%{name}

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%defattr(644,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
