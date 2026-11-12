%global gosec_version 2.30.0
%global gosec_release 2
%global debug_package %{nil}

Name:           gosec
Version:        %{gosec_version}
Release:        %{gosec_release}%{?dist}
Summary:        Go security checker
License:        Apache-2.0
URL:            https://securego.io/

Source0:        https://github.com/securego/gosec/archive/refs/tags/v%{version}.tar.gz

BuildRequires:  golang >= 1.26

Recommends:     /usr/bin/go

Provides:       gosec = %{version}-%{release}

%description
Go security checker

%prep
%autosetup -n %{name}-%{version} -p1

%build
export CGO_ENABLED=0
export GO_LD_FLAGS="-s \
                   -X main.Version=%{version}  \
                   -X main.GitTag=v%{version} \
                   -X main.BuildDate=$(date -u -d "@${SOURCE_DATE_EPOCH}" +%Y-%m-%dT%H:%M:%SZ)"
go build -o %{name} -trimpath -ldflags="${GO_LD_FLAGS}" ./cmd/gosec/...

%install
install -D -m 0755 %{name} %{buildroot}%{_bindir}/%{name}

%files
%license LICENSE.txt
%doc README.md RULES.md USERS.md
%{_bindir}/%{name}

%changelog
%autochangelog
