#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -ex

: ${R_BIN:=RDsan}

source_dir=${1}/r

${R_BIN} CMD INSTALL ${source_dir}
pushd ${source_dir}/tests

export TEST_R_WITH_ARROW=TRUE
export UBSAN_OPTIONS="print_stacktrace=1,suppressions=/arrow/r/tools/ubsan.supp"
${R_BIN} < testthat.R > testthat.out 2>&1 || { cat testthat.out; exit 1; }

cat testthat.out
if grep -q "runtime error" testthat.out; then
  exit 1
fi
popd
