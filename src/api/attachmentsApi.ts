import type { AttachmentTag, ScenarioAttachment } from '../types/notification'

const ATTACHMENTS_CACHE_KEY = 'seedling_attachments_cache_v1'

class AttachmentsApi {
  // Helper: Read local fallback cache
  private getLocalCache(): ScenarioAttachment[] {
    try {
      const stored = localStorage.getItem(ATTACHMENTS_CACHE_KEY)
      if (stored) {
        const parsed = JSON.parse(stored)
        if (Array.isArray(parsed)) {
          return parsed
        }
      }
    } catch {
      // ignore
    }
    return []
  }

  // Helper: Save to local fallback cache
  private setLocalCache(attachments: ScenarioAttachment[]) {
    try {
      localStorage.setItem(ATTACHMENTS_CACHE_KEY, JSON.stringify(attachments))
    } catch {
      // ignore
    }
  }

  // GET: Fetch all attachments for a specific scenario
  async fetchAttachments(scenarioId: string): Promise<ScenarioAttachment[]> {
    try {
      const res = await fetch(`/api/attachments?scenarioId=${encodeURIComponent(scenarioId)}`)
      if (res.ok) {
        const data = await res.json()
        const items = data.attachments || []

        // Merge into local cache
        const allCached = this.getLocalCache().filter((a) => a.scenarioId !== scenarioId)
        this.setLocalCache([...allCached, ...items])

        return items
      }
    } catch (err) {
      console.warn('Network error fetching attachments, using local cache:', err)
    }

    // Fallback to local cache
    return this.getLocalCache().filter((a) => a.scenarioId === scenarioId)
  }

  // GET: Fetch all attachments and counts per scenarioId (for badges in table view)
  async fetchAllAttachmentCounts(): Promise<Record<string, number>> {
    try {
      const res = await fetch('/api/attachments')
      if (res.ok) {
        const data = await res.json()
        if (data.counts) {
          return data.counts
        }
        if (Array.isArray(data.attachments)) {
          const counts: Record<string, number> = {}
          for (const a of data.attachments) {
            counts[a.scenarioId] = (counts[a.scenarioId] || 0) + 1
          }
          return counts
        }
      }
    } catch (err) {
      console.warn('Could not fetch attachment counts:', err)
    }

    // Fallback from local cache
    const cached = this.getLocalCache()
    const counts: Record<string, number> = {}
    for (const a of cached) {
      counts[a.scenarioId] = (counts[a.scenarioId] || 0) + 1
    }
    return counts
  }

  // POST: Upload a new screenshot or image to R2
  async uploadAttachment(
    scenarioId: string,
    file: File,
    tag: AttachmentTag = 'screenshot'
  ): Promise<ScenarioAttachment> {
    const formData = new FormData()
    formData.append('file', file)
    formData.append('scenarioId', scenarioId)
    formData.append('tag', tag)

    const res = await fetch('/api/attachments', {
      method: 'POST',
      body: formData,
    })

    if (!res.ok) {
      const errorData = await res.json().catch(() => ({}))
      throw new Error(errorData.error || `Upload failed with HTTP status ${res.status}`)
    }

    const data = await res.json()
    const attachment: ScenarioAttachment = data.attachment

    // Update local cache
    const current = this.getLocalCache()
    this.setLocalCache([attachment, ...current.filter((a) => a.id !== attachment.id)])

    return attachment
  }

  // DELETE: Remove attachment from R2 & D1
  async deleteAttachment(id: string): Promise<boolean> {
    const res = await fetch(`/api/attachments/${encodeURIComponent(id)}`, {
      method: 'DELETE',
    })

    if (!res.ok) {
      const errorData = await res.json().catch(() => ({}))
      throw new Error(errorData.error || `Delete failed with HTTP status ${res.status}`)
    }

    // Remove from local cache
    const current = this.getLocalCache()
    this.setLocalCache(current.filter((a) => a.id !== id))

    return true
  }
}

export const attachmentsApi = new AttachmentsApi()
