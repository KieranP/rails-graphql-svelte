<script lang="ts">
  import QRCode from 'qrcode'

  interface Props {
    content: string
  }

  const { content }: Props = $props()

  let canvas: HTMLElement

  $effect(() => {
    void QRCode.toCanvas(canvas, content, {
      width: 300
    })
  })
</script>

<canvas
  id="qrcode"
  bind:this={canvas}
></canvas>
