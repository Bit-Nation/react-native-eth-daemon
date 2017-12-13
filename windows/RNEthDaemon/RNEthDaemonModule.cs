using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Eth.Daemon.RNEthDaemon
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNEthDaemonModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNEthDaemonModule"/>.
        /// </summary>
        internal RNEthDaemonModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNEthDaemon";
            }
        }
    }
}
