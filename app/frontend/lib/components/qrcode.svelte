<script lang="ts">
  import { toCanvas } from 'qrcode'

  interface Props {
    content: string
  }

  const { content }: Props = $props()

  let canvas: HTMLElement

  $effect(() => {
    void toCanvas(canvas, content, {
      width: 300
    })
  })
</script>

<canvas
  id="qrcode"
  bind:this={canvas}
></canvas>
