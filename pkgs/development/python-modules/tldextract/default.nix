{ lib
, buildPythonPackage
, fetchPypi
, filelock
, idna
, pytest-mock
, pytestCheckHook
, pythonOlder
, requests
, requests-file
, responses
, setuptools
, setuptools-scm
}:

buildPythonPackage rec {
  pname   = "tldextract";
  version = "3.5.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-TfHGW5W+YdWUKOhhHpVeVObx1Eg9Po1XM9OpBiFV6RA=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = [
    filelock
    idna
    requests
    requests-file
  ];

  nativeCheckInputs = [
    pytest-mock
    pytestCheckHook
    responses
  ];

  postPatch = ''
    substituteInPlace pytest.ini \
      --replace " --pylint" ""
  '';

  pythonImportsCheck = [
    "tldextract"
  ];

  meta = with lib; {
    description = "Python module to accurately separate the TLD from the domain of an URL";
    longDescription = ''
      tldextract accurately separates the gTLD or ccTLD (generic or country code top-level domain)
      from the registered domain and subdomains of a URL.
    '';
    homepage = "https://github.com/john-kurkowski/tldextract";
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ fab ];
  };
}
