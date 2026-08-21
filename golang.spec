%global go_version 1.27.0
%global go_release 2
%global debug_package %{nil}

# Do not check any files in doc or src for requires
%global __requires_exclude_from ^(%{_datadir}|%{_libdir})/%{name}/(doc|src)/.*$

Name:           golang
Version:        %{go_version}
Release:        %{go_release}%{?dist}
Summary:        The Go programming language
License:        BSD-3-Clause
URL:            https://go.dev/

Source0:        https://go.dev/dl/go%{version}.src.tar.gz

BuildRequires:  golang >= 1.25
BuildRequires:  gcc
BuildRequires:  glibc-devel
BuildRequires:  make

Requires:       gcc
Requires:       glibc

Provides:       go = %{version}-%{release}

%description
Go is an open source programming language designed for building simple,
reliable, and efficient software.

%prep
%setup -q -n go

%build
cd src
./make.bash

%install
mkdir -p %{buildroot}%{_libdir}/%{name}
cp -a . %{buildroot}%{_libdir}/%{name}/
mkdir -p %{buildroot}%{_bindir}
ln -s %{_libdir}/%{name}/bin/go %{buildroot}%{_bindir}/go
ln -s %{_libdir}/%{name}/bin/gofmt %{buildroot}%{_bindir}/gofmt

%files
%license LICENSE PATENTS
%doc README.md VERSION
%{_bindir}/go
%{_bindir}/gofmt
%{_libdir}/%{name}/

%changelog
%autochangelog
