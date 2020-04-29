import os
import shutil
from glob import glob

CLEAN_CMD = "python setup.py clean"
CLEAN_QUIET_CMD = "python setup.py -q clean"

SDIST_CMD = "python setup.py sdist"
SDIST_QUIET_CMD = "python setup.py -q sdist"

BDIST_WHEEL_CMD = "python setup.py bdist_wheel"
BDIST_WHEEL_QUIET_CMD = "python setup.py -q bdist_wheel"

BUILD_EXT_QUIET_INPLACE = "python setup.py -q build_ext --inplace"

DEVELOP_QUIET_CMD = "python setup.py -q develop"

TEST_CMD = "pytest tests"

PUBLISH_CHECK_CMD = "twine check dist/*"

PUBLISH_CMD = " twine upload --non-interactive --skip-existing dist/*"
PUBLISH_WHEEL_CMD = " twine upload --non-interactive --skip-existing dist/*.whl"


def task_tests():
    return {
        "actions": [
            DEVELOP_QUIET_CMD,
            BUILD_EXT_QUIET_INPLACE,
            TEST_CMD,
            CLEAN_QUIET_CMD,
        ],
        "uptodate": [False],
        "verbosity": 2,
    }


def task_sdist():
    return {
        "actions": [SDIST_CMD, CLEAN_QUIET_CMD],
        "uptodate": [False],
        "verbosity": 2,
    }


def task_wheel():
    return {
        "actions": [BDIST_WHEEL_CMD, CLEAN_QUIET_CMD],
        "uptodate": [False],
        "verbosity": 2,
    }


def task_clear():
    return {
        "actions": [CLEAN_CMD],
        "uptodate": [False],
        "verbosity": 2,
    }


def CLEAR_DISTS():
    if os.path.isdir("dist"):
        shutil.rmtree("dist")


def task_publish_sdist():
    return {
        "actions": [
            DEVELOP_QUIET_CMD,
            BUILD_EXT_QUIET_INPLACE,
            TEST_CMD,
            CLEAR_DISTS,
            SDIST_CMD,
            PUBLISH_CHECK_CMD,
            PUBLISH_CMD,
            CLEAN_CMD,
        ],
        "uptodate": [False],
        "verbosity": 2,
    }


def task_publish_wheel():
    return {
        "actions": [
            DEVELOP_QUIET_CMD,
            BUILD_EXT_QUIET_INPLACE,
            TEST_CMD,
            CLEAR_DISTS,
            BDIST_WHEEL_CMD,
            PUBLISH_CHECK_CMD,
            PUBLISH_WHEEL_CMD,
            CLEAN_CMD,
        ],
        "uptodate": [False],
        "verbosity": 2,
    }
