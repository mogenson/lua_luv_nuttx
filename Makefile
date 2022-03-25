############################################################################
# apps/external/lua_luv_nuttx/Makefile
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.  The
# ASF licenses this file to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.
#
############################################################################

include $(APPDIR)/Make.defs

# Luv library

LUV_VERSION  = $(patsubst "%",%,$(strip $(CONFIG_LUA_LUV_VERSION)))
LUV_TARBALL  = luv-$(LUV_VERSION).tar.gz
LUV_UNPACK   = luv-$(LUV_VERSION)
LUV_URL_BASE = https://github.com/luvit/luv/releases/download/
LUV_URL      = $(LUV_URL_BASE)/$(LUV_VERSION)/$(LUV_TARBALL)
LUV_SRC      = $(LUV_UNPACK)$(DELIM)src

# Luv download and unpack

$(LUV_TARBALL):
	$(Q) echo "Downloading $(LUV_TARBALL)"
	$(Q) curl -O -L $(LUV_URL)

$(LUV_UNPACK): $(LUV_TARBALL)
	$(Q) echo "Unpacking $(LUV_TARBALL) to $(LUV_UNPACK)"
	$(Q) tar -xvzf $(LUV_TARBALL)

context:: $(LUV_UNPACK)

distclean::
	$(call DELDIR, $(LUV_UNPACK))
	$(call DELFILE, $(LUV_TARBALL))

# Set LUAMODNAME and include Module.mk to add this module to the list of
# builtin modules for the Lua interpreter. LUAMODNAME should match the
# module's luaopen function.

LUAMODNAME = luv

CSRCS = $(LUV_SRC)$(DELIM)luv.c

include $(APPDIR)/interpreters/lua/Module.mk

include $(APPDIR)/Application.mk
