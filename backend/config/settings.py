import os
from pathlib import Path
from datetime import timedelta
from dotenv import load_dotenv

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

load_dotenv(os.path.join(BASE_DIR, '.env'))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv('SECRET_KEY')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG_STR = os.getenv('DEBUG', 'False')
DEBUG = DEBUG_STR.strip().upper() == 'TRUE' # 문자열을 논리값으로 변환

ALLOWED_HOSTS_STR = os.getenv('ALLOWED_HOSTS', '') # 환경 변수가 없으면 기본값 빈 문자열
if DEBUG and not ALLOWED_HOSTS_STR :
    # DEBUG 모드이고 ALLOWED_HOSTS가 .env 명시적으로 설정되지 않은 경우, 기본값 사용
    ALLOWED_HOSTS = ['localhost', '127.0.0.1']
elif ALLOWED_HOSTS_STR :
    # .env에 값이 설정 된 경우, 해당 값을 파싱하여 사용
    ALLOWED_HOSTS = [host.strip() for host in ALLOWED_HOSTS_STR.split(',')]
else :
    # DEBUG 모드가 아니거나, .env에 값이 명시적으로 빈 문자열로 설정 된 경우 빈 리스트
    # (프로덕션에서는 빈 리스트면 오류 발생)
    ALLOWED_HOSTS = []

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    'rest_framework',
    'rest_framework_simplejwt',
    
    'drf_yasg',
    'corsheaders',
    'django_celery_beat',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'config.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'config.wsgi.application'

# Redis

REDIS_HOST = os.getenv('REDIS_HOST', 'redis')
REDIS_PORT = int(os.getenv('REDIS_PORT', 6379))
REDIS_DB = int(os.getenv('REDIS_DB', 0))

# caches

CACHES = {
    'default' : {
        'BACKEND' : 'django_redis.cache.RedisCache',
        'LOCATION' : f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_DB}", # Redis 서버 주소 ( 기본 포트 6379 )
        'OPTIONS' : {
            'CLIENT_CLASS' : 'django_redis.client.DefaultClient',
        }
    }
}

SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'default' # 기본 캐시를 사용

# Internationalization
# https://docs.djangoproject.com/en/5.1/topics/i18n/

LANGUAGE_CODE = 'ko-kr'

TIME_ZONE = 'Asia/Seoul'

USE_I18N = True

USE_L10N = True

USE_TZ = True

#celery

CELERY_BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_DB}"
CELERY_ACCEPT_CONTENT = ['json']
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_DB}"
CELERY_TIMEZONE = TIME_ZONE
CELERY_BEAT_SCHEDULER = 'django_celery_beat.schedulers:DatabaseScheduler'
CELERY_TASK_TRACKSTARTED = True


# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE' : os.getenv('DB_ENGINE'),
        'NAME' : os.getenv('DB_NAME'),
        'USER' : os.getenv('DB_USER'),
        'PASSWORD' : os.getenv('DB_PASSWORD'),
        'HOST' : os.getenv('DB_HOST'),
        'PORT' : os.getenv('DB_PORT'),
    }
}


# Password validation
# https://docs.djangoproject.com/en/5.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]




# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.1/howto/static-files/

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, '.static_root')

MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'

FIXTURE_DIRS = [
    BASE_DIR / 'fixtures/',
]

# Default primary key field type
# https://docs.djangoproject.com/en/5.1/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Django REST Framework 설정
REST_FRAMEWORK = {
    # API 문서화 스키마 자동 생성
    # 'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
    # 기본 인증 방식으로 JWT 사용
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ),
    # 기본 권한으로 인증된 사용자만 허용
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.IsAuthenticated',
    ),
    # 일관된 예외 처리를 위한 핸들러 (추후 커스텀 가능)
    # 'EXCEPTION_HANDLER': 'seead_web.api.exceptions.custom_exception_handler',
}

# DRF Spectacular (API 문서) 설정
SPECTACULAR_SETTINGS = {
    'TITLE': 'SeeAd Project API',
    'DESCRIPTION': 'SeeAd 프로젝트의 웹/앱 공용 API 명세서',
    'VERSION': '1.0.0',
    'SERVE_INCLUDE_SCHEMA': False,
}

# CORS 설정 (Cross-Origin Resource Sharing)
# 웹 프론트엔드 주소와 앱 스킴(Scheme)을 허용
CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000", # 예: React 개발 서버
    "http://127.0.0.1:3000",
    "https://your-web-domain.com",
]
# Flutter 앱의 경우 특정 Origin이 없으므로, 필요에 따라 정규식 또는 패턴을 사용
CORS_ALLOWED_ORIGIN_REGEXES = [
    r"^https://.*\.your-app-domain\.com$",
    r"^capacitor://.*$",
    r"^flutter-app://.*$", # 가상의 스킴, 실제 앱 환경에 맞게 조정 필요
]
# CORS_ALLOW_ALL_ORIGINS = True # 개발 초기 단계에서만 사용

REST_USE_JWT = True
# 추가적인 jwt_auth 설정
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=5),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=1),
    "ROTATE_REFRESH_TOKENS": True,  # Refresh Token 회전 활성화
    "BLACKLIST_AFTER_ROTATION": True, # 사용된 Refresh Token을 블랙리스트에 추가
    "UPDATE_LAST_LOGIN": False,

    "ALGORITHM": "HS256",
    "SIGNING_KEY": SECRET_KEY,
    "VERIFYING_KEY": None,
    "AUDIENCE": None,
    "ISSUER": None,
    "JWK_URL": None,
    "LEEWAY": 0,

    "AUTH_HEADER_TYPES": ("Bearer",), # 'Bearer' 타입 헤더 사용 명시
    "AUTH_HEADER_NAME": "HTTP_AUTHORIZATION",
    "USER_ID_FIELD": "id",
    "USER_ID_CLAIM": "user_id",
    "USER_AUTHENTICATION_RULE": "rest_framework_simplejwt.authentication.default_user_authentication_rule",

    "AUTH_TOKEN_CLASSES": ("rest_framework_simplejwt.tokens.AccessToken",),
    "TOKEN_TYPE_CLAIM": "token_type",
    "TOKEN_USER_CLASS": "rest_framework_simplejwt.models.TokenUser",

    "JTI_CLAIM": "jti",

    "SLIDING_TOKEN_REFRESH_EXP_CLAIM": "refresh_exp",
    "SLIDING_TOKEN_LIFETIME": timedelta(minutes=5),
    "SLIDING_TOKEN_REFRESH_LIFETIME": timedelta(days=1),
}
GROUP_PREFIX = {
    "MASTER_PREFIX" : "master",
}
PASSWORD_RESET_TIMEOUT_DAYS = 1

# EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
# EMAIL_HOST = os.getenv('EMAIL_HOST')
# EMAIL_PORT = int(os.getenv('EMAIL_PORT'))
# EMAIL_HOST_USER = os.getenv('EMAIL_HOST_USER')
# EMAIL_HOST_PASSWORD = os.getenv('EMAIL_HOST_PASSWORD')
# EMAIL_USE_TLS = True
# DEFAULT_FROM_EMAIL = EMAIL_HOST_USER
# SERVICE_APP_ADMIN_KEY = config["SERVICE_APP_ADMIN_KEY"]

# Reward Claim Limits (Daily) per member level
# Format: {'member_level': limit}
# Example: 'user' can claim up to 10 rewards daily, 'advertiser' and 'agency' cannot.
REWARD_CLAIM_DAILY_LIMITS = {
    'B': 10,
    'A': 100,
    'S': 1000,
    # Add other member level if needed
}

# Default limit if member level is not in the dictionary
DEFAULT_REWARD_CLAIM_DAILY_LIMIT = 0

SWAGGER_SETTINGS = {
    'USE_SESSION_AUTH': False,  # 세션 인증 비활성화
    'SECURITY_DEFINITIONS': {
        'Bearer': {
            'type': 'apiKey',
            'name': 'Authorization',
            'in': 'header',
            'description': 'JWT 형식으로 입력하세요. 예: **Bearer &lt;access_token&gt;**',
        }
    },
    'DEFAULT_MODEL_RENDERING': 'example',
    'DOC_EXPANSION': 'none',
}