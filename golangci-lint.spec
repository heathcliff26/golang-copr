%global gocilint_version 2.13.1
%global gocilint_release 1
%global debug_package %{nil}

Name:           golangci-lint
Version:        %{gocilint_version}
Release:        %{gocilint_release}%{?dist}
Summary:        Fast linters Runner for Go
License:        GPLv3
URL:            https://golangci-lint.run/

Source0:        https://github.com/golangci/golangci-lint/archive/refs/tags/v%{version}.tar.gz

BuildRequires:  golang >= 1.26

Recommends:     /usr/bin/go

Provides:       golangci-lint = %{version}-%{release}

%description
Fast linters Runner for Go

%prep
%autosetup -n %{name}-%{version} -p1

%build
export CGO_ENABLED=0
export GO_LD_FLAGS="-X main.version=%{version}  \
                   -X main.commit=Copr \
                   -X main.date=$(date -u -d "@${SOURCE_DATE_EPOCH}" +%Y-%m-%dT%H:%M:%SZ)"
go build -o %{name} -trimpath -ldflags="${GO_LD_FLAGS}" ./cmd/golangci-lint/...

%install
install -D -m 0755 %{name} %{buildroot}%{_bindir}/%{name}

%files
%license LICENSE
%doc README.md
%{_bindir}/%{name}

%changelog
%autochangelog
