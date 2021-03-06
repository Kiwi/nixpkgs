{ lib
, buildPythonPackage
, fetchPypi
, django
, persisting-theory
, six
}:

buildPythonPackage rec {
  pname = "django-dynamic-preferences";
  version = "1.10.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "e4b2bb7b2563c5064ba56dd76441c77e06b850ff1466a386a1cd308909a6c7de";
  };

  propagatedBuildInputs = [ six django persisting-theory ];

  # django.core.exceptions.ImproperlyConfigured: Requested setting DYNAMIC_PREFERENCES, but settings are not configured. You must either define the environment variable DJANGO_SETTINGS_MODULE or call settings.configure() before accessing settings
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/EliotBerriot/django-dynamic-preferences";
    description = "Dynamic global and instance settings for your django project";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mmai ];
  };
}
