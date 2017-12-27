package com.reactlibrary;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import org.ethereum.geth.Geth;
import org.ethereum.geth.Node;
import org.ethereum.geth.NodeConfig;
import org.json.JSONException;

import java.io.File;

/**
 * Created by Estarrona on 22/12/17.
 */

public class RNEthDaemonModule extends ReactContextBaseJavaModule {

    private Node node;
    final String TAG = "GethNode";

    public RNEthDaemonModule (ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "RNEthDaemon";
    }

    @ReactMethod
    public void startDaemon(ReadableMap jsonConfig) throws JSONException {
        Log.d("GethNode", "Starting Geth process" );

        NodeConfig nodeConfig = Geth.newNodeConfig();
        Log.d("GethNode", "New node" );

        nodeConfig.setEthereumEnabled(jsonConfig.getBoolean("enabledEthereum"));
        nodeConfig.setEthereumDatabaseCache(jsonConfig.getInt("enodesNumber"));
        nodeConfig.setEthereumNetworkID(jsonConfig.getInt("networkID"));
        nodeConfig.setMaxPeers(jsonConfig.getInt("maxPeers"));
        nodeConfig.setWhisperEnabled(jsonConfig.getBoolean("enabledWhisper"));

        String genesis = Geth.testnetGenesis();
        nodeConfig.setEthereumGenesis(genesis);

        Log.d("GethNode", "Configured" );

        final String root = getReactApplicationContext().getBaseContext().getApplicationInfo().dataDir;
        final String dataFolder = root + "/.ethereum";
        Log.d("GethNode", "Starting Geth node in folder: " + dataFolder);

        Log.d("GethNode", "Have the root/folder" );

        try {
            final File newFile = new File(dataFolder);
            newFile.mkdir();
        } catch (Exception e) {
            Log.e(TAG, "error making folder: " + dataFolder, e);
        }

        final String networkDir = dataFolder + "/$TMPDIR";

        node = new Node(networkDir, nodeConfig);
        Log.d(TAG, "Node config " + nodeConfig);

        try {
            node.start();
        } catch (Exception e) {
            e.printStackTrace();
        }

        Log.d(TAG, "Geth node started");
    }

    @ReactMethod
    public void stopDaemon() {
        try {
            node.stop();
        } catch (Exception e) {
            e.printStackTrace();
        }

        Log.d(TAG, "Geth node stoped");
    }

}