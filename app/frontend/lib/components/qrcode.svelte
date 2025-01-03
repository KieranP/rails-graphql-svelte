<script lang="ts">
  import { toCanvas } from 'qrcode'
  import { onMount } from 'svelte'

  interface Props {
    content: string
  }

  const { content }: Props = $props()

  let canvas: HTMLElement | undefined = $state()

  onMount(() => {
    if (!canvas) return

    void toCanvas(canvas, content, {
      width: 300,
    })
  })
</script>

<canvas
  bind:this={canvas}
  id="qrcode"
></canvas>
