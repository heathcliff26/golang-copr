%global go_version 1.27.0
%global go_release 1
%global debug_package %{nil}

Name:           golang
Version:        %{go_version}
Release:        %{go_release}%{?dist}
Summary:        The Go programming language
License:        BSD-3-Clause
URL:            https://go.dev/

Source0:        go%{version}.src.tar.gz

BuildRequires:  golang >= 1.22
BuildRequires:  gcc
BuildRequires:  glibc-devel
BuildRequires:  make
Requires:       glibc
Provides:       golang = %{version}-%{release}

%description
Go is an open source programming language designed for building simple,
reliable, and efficient software.

%prep
%setup -q -n go

%build
cd src
./make.bash

%install
mkdir -p %{buildroot}%{_libdir}/golang
cp -a . %{buildroot}%{_libdir}/golang/
mkdir -p %{buildroot}%{_bindir}
ln -s %{_libdir}/golang/bin/go %{buildroot}%{_bindir}/go
ln -s %{_libdir}/golang/bin/gofmt %{buildroot}%{_bindir}/gofmt

%files
%license LICENSE PATENTS
%doc README.md VERSION
%{_bindir}/go
%{_bindir}/gofmt
%{_libdir}/golang/

%changelog
%autochangelog
