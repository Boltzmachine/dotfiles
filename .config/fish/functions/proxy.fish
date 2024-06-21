function proxy
	set -gx HTTP_PROXY http://127.0.0.1:7890
	set -gx HTTPS_PROXY http://127.0.0.1:7890
	set -gx ALL_PROXY socks5://127.0.0.1:7890
end

function noproxy
	set -e HTTP_PROXY
	set -e HTTPS_PROXY
	set -e ALL_PROXY
end
