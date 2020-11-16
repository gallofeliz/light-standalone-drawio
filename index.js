<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0" />

    <style type="text/css">

    body, html {
        margin: 0; padding: 0; height: 100%; overflow: hidden;
    }

    </style>
</head>

<body>
    <iframe src="https://embed.diagrams.net/?embed=1&proto=json&noExitBtn=1&spin=1&modified=1" width="100%" height="100%" frameborder="0"></iframe>

    <script type="text/javascript">

        var iframe = document.querySelector('iframe');
        var origin = (new URL(iframe.src)).origin;
        var file = './data.xml';

        window.addEventListener("message", async function (event) {

            if (event.origin !== origin) {
                return false;
            }

            event = JSON.parse(event.data);

            console.log(event)

            if (event.event === 'init') {
                iframe.contentWindow.postMessage(JSON.stringify({
                    action: 'load',
                    xml: await (await fetch(file)).text()
                }), origin);
            }

            if (event.event === 'save') {

                iframe.contentWindow.postMessage(JSON.stringify({
                    action: 'spinner',
                    message:'Saving...',
                    show: true,
                    enabled: false
                }), origin);

                console.log(event.xml)

                setTimeout(function () {
                    iframe.contentWindow.postMessage(JSON.stringify({
                        action: 'spinner',
                        show: false,
                    }), origin);

                    iframe.contentWindow.postMessage(JSON.stringify({
                        action: 'status',
                        message:'Saved',
                        modified: false
                    }), origin);

                }, 1000);

            }

        }, false);

    </script>
</body>

</html>
