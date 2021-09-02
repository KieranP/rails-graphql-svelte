<script lang="ts">
  import { onMount } from 'svelte'
  import QRCode from 'qrcode/build/qrcode'

  export let content: string

  let canvas: any

  onMount(() => {
    QRCode.toCanvas(canvas, content, {
      width: 300
    })
  })
</script>

<canvas id="qrcode" bind:this={canvas} />
