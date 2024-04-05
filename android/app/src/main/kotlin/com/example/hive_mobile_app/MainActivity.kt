package com.example.hive_mobile_app

import android.annotation.SuppressLint
import android.content.Context
import android.net.Uri
import android.os.Build
import android.view.View
import android.webkit.JavascriptInterface
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.webkit.WebViewAssetLoader
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private var webView: WebView? = null
    var handlers: MutableMap<String, MethodChannel.Result> = mutableMapOf()

      fun getValue(value: String?): String {
        if (value == null) {
            return "null"
        }
        return "'$value'";
    }

    fun getIntValue(value: Int?): String {
        if (value == null) {
            return "null"
        }
        return "$value";
    }

    fun getBoolValue(value: Boolean?): String {
        if (value == null) {
            return "null"
        }
        if (value == true) {
            return "true"
        }
        return "false"
    }

    fun getDoubleValue(value: Double?): String {
        if (value == null) {
            return "null"
        }
        return "$value";
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        if (webView == null) {
            setupView()
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "app.the-hive-mobile/bridge"
        ).setMethodCallHandler { call, result ->
            val id = call.argument<String?>("id")
            if (id == null) {
                result.error(
                    "UNAVAILABLE",
                    "Identifier for the flutter platform call not found",
                    null
                )
                return@setMethodCallHandler
            } else {
                handlers[id] = result

                val limit = call.argument<Int?>("limit")
                val lastName = call.argument<String?>("lastName") 
                if (call.method == "getChainProps" ) {
                    webView?.evaluateJavascript(
                        "getChainProps('$id');",
                        null
                    )
                } else if (call.method == "getFeed" ) {
                    val feedType = call.argument<String?>("feed_type") ?: "trending"
                    webView?.evaluateJavascript(
                        "getFeed('$id', '$feedType');",
                        null
                    )
                } else if (call.method == "getListOfCommunities" && limit != null ) {
                    webView?.evaluateJavascript(
                        "getListOfCommunities('$id', ${getIntValue(limit)},${getValue(lastName)});",
                        null
                    )
                } else if (call.method == "getWitnesses" && limit != null ) {
                    webView?.evaluateJavascript(
                        "getWitnesses('$id', ${getIntValue(limit)},${getValue(lastName)});",
                        null
                    )
                }
            }
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun setupView() {
        val params = FrameLayout.LayoutParams(0, 0)
        webView = WebView(this)
        val decorView = this.window.decorView as FrameLayout
        decorView.addView(webView, params)
        webView?.visibility = View.GONE
        webView?.settings?.javaScriptEnabled = true
        webView?.settings?.domStorageEnabled = true
//        webView?.webChromeClient = WebChromeClient()
        WebView.setWebContentsDebuggingEnabled(true)
        val assetLoader = WebViewAssetLoader.Builder()
            .addPathHandler("/assets/", WebViewAssetLoader.AssetsPathHandler(this))
            .build()
        val client: WebViewClient = object : WebViewClient() {
            @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
            override fun shouldInterceptRequest(
                view: WebView,
                request: WebResourceRequest
            ): WebResourceResponse? {
                return assetLoader.shouldInterceptRequest(request.url)
            }

            override fun shouldInterceptRequest(
                view: WebView,
                url: String
            ): WebResourceResponse? {
                return assetLoader.shouldInterceptRequest(Uri.parse(url))
            }
        }
        webView?.webViewClient = client
        webView?.addJavascriptInterface(WebAppInterface(this), "Android")
        webView?.loadUrl("https://appassets.androidplatform.net/assets/index.html")
    }
}

class WebAppInterface(private val mContext: Context) {
    @JavascriptInterface
    fun postMessage(message: String) {
        val main = mContext as? MainActivity ?: return
        val gson = Gson()
        val dataObject = gson.fromJson(message, JSEvent::class.java)
        main.handlers[dataObject.id]?.success(message)
        main.handlers.remove(dataObject.id)
    }
}

data class JSEvent(
    var id: String,
)

