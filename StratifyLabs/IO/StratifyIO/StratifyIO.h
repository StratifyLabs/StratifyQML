/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

#ifndef STRATIFYIO_H
#define STRATIFYIO_H

namespace StratifyIO {
;
}

using namespace StratifyIO;

//Data structure objects
#include "AppData.h"
#include "HardwareData.h"
#include "UserData.h"
#include "DeviceData.h"

//Hardware Access classes
#include "IO.h"
#include "PortIO.h"
#include "ConnectionIO.h"
#include "NotificationIO.h"
#include "AppIO.h"
#include "KernelIO.h"
#include "TerminalIO.h"

//Thread Management
#include "Worker.h"


//Helper Routines
#include "Helper.h"






#endif // STRATIFYIO_H
