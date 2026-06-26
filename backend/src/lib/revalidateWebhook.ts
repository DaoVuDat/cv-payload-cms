export async function triggerWebhook() {
  if (!process.env.WEBHOOK) {
    console.log('VERCEL_DEPLOY_HOOK_URL not set. Skipping rebuild.')
    return
  }

  try {
    // Send a POST request to the Vercel deploy hook URL
    const response = await fetch(process.env.WEBHOOK, {
      method: 'POST',
    })

    if (response.ok) {
      console.log('Successfully triggered Vercel rebuild.')
    } else {
      console.error('Failed to trigger Vercel rebuild:', await response.text())
    }
  } catch (error) {
    console.error('Error triggering Vercel rebuild:', error)
  }
}
