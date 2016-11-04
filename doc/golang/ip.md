

https://husobee.github.io/golang/ip-address/2015/12/17/remote-ip-go.html

https://github.com/sebest/xff


https://recalll.co/app/?q=go%20-%20Correct%20way%20of%20getting%20Client%27s%20IP%20Addresses%20from%20http.Request%20(golang)

req.Header.Get("X-Forwarded-For")
req.Header.Get("x-forwarded-for")
req.Header.Get("X-FORWARDED-FOR")
HTTP_X_FORWARDED_FOR

## https://groups.google.com/forum/#!topic/golang-nuts/lomWKs0kOfE

// Request.RemoteAddress contains port, which we want to remove i.e.:
// "[::1]:58292" => "[::1]"
func ipAddrFromRemoteAddr(s string) string {
        idx := strings.LastIndex(s, ":")
        if idx == -1 {
                return s
        }
        return s[:idx]
}

func getIpAddress(r *http.Request) string {
        hdr := r.Header
        hdrRealIp := hdr.Get("X-Real-Ip")
        hdrForwardedFor := hdr.Get("X-Forwarded-For")
        if hdrRealIp == "" && hdrForwardedFor == "" {
                return ipAddrFromRemoteAddr(r.RemoteAddr)
        }
        if hdrForwardedFor != "" {
                // X-Forwarded-For is potentially a list of addresses separated with ","
                parts := strings.Split(hdrForwardedFor, ",")
                for i, p := range parts {
                        parts[i] = strings.TrimSpace(p)
                }
                // TODO: should return first non-local address
                return parts[0]
        }
        return hdrRealIp
}

The main point of the code is that "X-Forwarded-For" header can be a
list of ip addresses and I also use "X-Real-Ip" if "X-Forwarded-For"
is not present.

According to http://rod.vagg.org/2011/07/wrangling-the-x-forwarded-for-header/,
I should really use the first non-local ip address from
"X-Forwarded-For" list but I ran out of steam.

-- kjk

On Sat, Oct 20, 2012 at 9:31 PM, PeteT <peter...@ymail.com> wrote:
> When running behind a proxy, wrap your application's mux with a handler that
> modifies the request with the x-fowarded-for header:
>
> type remoteAddrFixup struct {
>     h http.Handler
> }
>
> func (h remoteAddrFixup) ServeHTTP(w http.ResponseWriter, r *http.Request) {
>    r.RemoteAddr = r.Header.Get("X-Forwarded-For")
>    h.h(w, r)
> }
>
> Assuming that you are using the default serve mux, you can do something like
> this in your application main:
>
>   var h http.Handler
>   if runningBehindProxy {
>      h = remoteAddrFixup{http.DefaultServeMux}
>  } else {
>      h = http.DefaultServeMux
>  }
>  http.ListenAndServe(addr, h)
>
