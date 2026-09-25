import React, { useState, useEffect, useRef } from 'react'
import type { ScenarioAttachment } from '../../types/notification'
import { attachmentsApi } from '../../api/attachmentsApi'
import {
  UploadCloud,
  Trash2,
  ZoomIn,
  ZoomOut,
  X,
  ChevronLeft,
  ChevronRight,
  Download,
  Loader2,
  AlertCircle,
  Eye,
} from 'lucide-react'

interface ScenarioAttachmentsSectionProps {
  scenarioId: string
  scenarioKey?: string
  onAttachmentsChange?: (count: number) => void
}

function formatBytes(bytes: number): string {
  if (bytes === 0) return '0 B'
  const k = 1024
  const sizes = ['B', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return `${parseFloat((bytes / Math.pow(k, i)).toFixed(1))} ${sizes[i]}`
}

export const ScenarioAttachmentsSection: React.FC<ScenarioAttachmentsSectionProps> = ({
  scenarioId,
  onAttachmentsChange,
}) => {
  const [attachments, setAttachments] = useState<ScenarioAttachment[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [isUploading, setIsUploading] = useState(false)
  const [uploadError, setUploadError] = useState<string | null>(null)
  const [lightboxIndex, setLightboxIndex] = useState<number | null>(null)
  const [zoomLevel, setZoomLevel] = useState(1)
  const [isDragging, setIsDragging] = useState(false)
  const [deletingId, setDeletingId] = useState<string | null>(null)

  const fileInputRef = useRef<HTMLInputElement>(null)
  const onAttachmentsChangeRef = useRef(onAttachmentsChange)
  useEffect(() => {
    onAttachmentsChangeRef.current = onAttachmentsChange
  })

  // Fetch attachments on mount or when scenarioId changes
  useEffect(() => {
    let isMounted = true
    setIsLoading(true)
    setUploadError(null)

    attachmentsApi
      .fetchAttachments(scenarioId)
      .then((items) => {
        if (isMounted) {
          setAttachments(items)
          setIsLoading(false)
          onAttachmentsChangeRef.current?.(items.length)
        }
      })
      .catch((err) => {
        if (isMounted) {
          console.error('Failed to load attachments:', err)
          setIsLoading(false)
        }
      })

    return () => {
      isMounted = false
    }
  }, [scenarioId])

  // Handle file upload
  const handleUploadFiles = async (files: FileList | null) => {
    if (!files || files.length === 0) return
    setIsUploading(true)
    setUploadError(null)

    try {
      const uploadPromises = Array.from(files).map((file) =>
        attachmentsApi.uploadAttachment(scenarioId, file, 'screenshot')
      )
      const newItems = await Promise.all(uploadPromises)

      setAttachments((prev) => {
        const updated = [...newItems, ...prev]
        onAttachmentsChangeRef.current?.(updated.length)
        return updated
      })
    } catch (err: any) {
      console.error('Upload error:', err)
      setUploadError(err.message || 'Failed to upload screenshot.')
    } finally {
      setIsUploading(false)
      if (fileInputRef.current) {
        fileInputRef.current.value = ''
      }
    }
  }

  // Handle attachment deletion
  const handleDelete = async (id: string, e: React.MouseEvent) => {
    e.stopPropagation()
    if (!window.confirm('Delete this screenshot?')) {
      return
    }

    setDeletingId(id)
    try {
      await attachmentsApi.deleteAttachment(id)
      setAttachments((prev) => {
        const updated = prev.filter((a) => a.id !== id)
        onAttachmentsChangeRef.current?.(updated.length)
        return updated
      })
      if (lightboxIndex !== null) {
        setLightboxIndex(null)
      }
    } catch (err: any) {
      alert(`Failed to delete: ${err.message || 'Unknown error'}`)
    } finally {
      setDeletingId(null)
    }
  }

  // Drag and drop handlers
  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(true)
  }

  const handleDragLeave = () => {
    setIsDragging(false)
  }

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(false)
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      handleUploadFiles(e.dataTransfer.files)
    }
  }

  // Lightbox keyboard navigation
  useEffect(() => {
    if (lightboxIndex === null) return

    const handleKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setLightboxIndex(null)
        setZoomLevel(1)
      } else if (e.key === 'ArrowLeft') {
        setLightboxIndex((prev) =>
          prev !== null && prev > 0 ? prev - 1 : attachments.length - 1
        )
        setZoomLevel(1)
      } else if (e.key === 'ArrowRight') {
        setLightboxIndex((prev) =>
          prev !== null && prev < attachments.length - 1 ? prev + 1 : 0
        )
        setZoomLevel(1)
      }
    }

    window.addEventListener('keydown', handleKey)
    return () => window.removeEventListener('keydown', handleKey)
  }, [lightboxIndex, attachments.length])

  return (
    <div className="space-y-1.5">
      {/* Hidden file input */}
      <input
        ref={fileInputRef}
        type="file"
        accept="image/*,.png,.jpg,.jpeg,.webp,.gif,.svg"
        multiple
        className="hidden"
        onChange={(e) => handleUploadFiles(e.target.files)}
      />

      {/* Clean Minimal Header */}
      <div className="flex items-center justify-between px-0.5">
        <div className="flex items-center gap-1.5">
          <span className="text-[11px] font-semibold text-[#6B778C]">Screenshots</span>
          {attachments.length > 0 && (
            <span className="text-[10px] font-semibold px-1.5 py-0.2 rounded-full bg-[#EBECF0] text-[#5E6C84]">
              {attachments.length}
            </span>
          )}
        </div>

        <button
          type="button"
          disabled={isUploading}
          onClick={() => fileInputRef.current?.click()}
          className="text-[11px] font-semibold text-[#0052CC] hover:text-[#0747A6] hover:bg-blue-50 px-2 py-0.5 rounded transition cursor-pointer flex items-center gap-1 disabled:opacity-50"
        >
          {isUploading ? (
            <Loader2 className="w-3 h-3 animate-spin" />
          ) : (
            <UploadCloud className="w-3 h-3" />
          )}
          <span>{isUploading ? 'Uploading...' : 'Upload'}</span>
        </button>
      </div>

      {/* Error banner */}
      {uploadError && (
        <div className="p-1.5 rounded-md bg-red-50 border border-red-200 text-red-700 text-[11px] flex items-center gap-2">
          <AlertCircle className="w-3 h-3 shrink-0 text-red-500" />
          <span className="flex-1">{uploadError}</span>
          <button
            type="button"
            onClick={() => setUploadError(null)}
            className="text-red-500 hover:text-red-700 cursor-pointer"
          >
            <X className="w-3 h-3" />
          </button>
        </div>
      )}

      {/* Content Area */}
      {isLoading ? (
        <div className="py-2 flex items-center justify-center text-[#6B778C] gap-1.5 text-[11px]">
          <Loader2 className="w-3.5 h-3.5 animate-spin text-[#0052CC]" />
          <span>Loading...</span>
        </div>
      ) : attachments.length === 0 ? (
        /* Very Small Compact Drop Box */
        <div
          onDragOver={handleDragOver}
          onDragLeave={handleDragLeave}
          onDrop={handleDrop}
          onClick={() => fileInputRef.current?.click()}
          className={`border border-dashed rounded-md py-1 px-2.5 text-center transition cursor-pointer w-full sm:w-fit inline-flex items-center justify-center gap-1.5 ${
            isDragging
              ? 'border-[#0052CC] bg-blue-50/50'
              : 'border-black/10 hover:border-[#0052CC] bg-[#F2F2F7]/95 hover:bg-[#EAEAEE]'
          }`}
        >
          <UploadCloud className="w-3.5 h-3.5 text-[#0052CC] shrink-0" />
          <span className="text-[11px] text-[#6B778C]">
            Click or drag image to attach screenshot
          </span>
        </div>
      ) : (
        /* Clean Compact Thumbnail Grid with inline Add card */
        <div
          onDragOver={handleDragOver}
          onDragLeave={handleDragLeave}
          onDrop={handleDrop}
          className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-6 gap-2"
        >
          {attachments.map((attachment, index) => {
            const isDeleting = deletingId === attachment.id

            return (
              <div
                key={attachment.id}
                onClick={() => {
                  setLightboxIndex(index)
                  setZoomLevel(1)
                }}
                className="group relative bg-white border border-[#DFE1E6] hover:border-[#0052CC] rounded-lg overflow-hidden shadow-2xs hover:shadow-xs transition cursor-pointer flex flex-col"
              >
                {/* Thumbnail */}
                <div className="relative aspect-4/3 bg-[#FAFBFC] overflow-hidden flex items-center justify-center">
                  <img
                    src={attachment.publicUrl}
                    alt={attachment.fileName}
                    loading="lazy"
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-150"
                  />

                  {/* Hover Actions */}
                  <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
                    <button
                      type="button"
                      title="View Fullscreen"
                      onClick={(e) => {
                        e.stopPropagation()
                        setLightboxIndex(index)
                        setZoomLevel(1)
                      }}
                      className="w-7 h-7 rounded-full bg-white text-[#172B4D] hover:bg-slate-100 flex items-center justify-center shadow-xs cursor-pointer"
                    >
                      <Eye className="w-3.5 h-3.5" />
                    </button>

                    <button
                      type="button"
                      title="Delete"
                      disabled={isDeleting}
                      onClick={(e) => handleDelete(attachment.id, e)}
                      className="w-7 h-7 rounded-full bg-red-600 hover:bg-red-700 text-white flex items-center justify-center shadow-xs cursor-pointer disabled:opacity-50"
                    >
                      {isDeleting ? (
                        <Loader2 className="w-3.5 h-3.5 animate-spin" />
                      ) : (
                        <Trash2 className="w-3.5 h-3.5" />
                      )}
                    </button>
                  </div>
                </div>

                {/* File info footer */}
                <div className="p-1.5 bg-white border-t border-[#EBECF0] flex items-center justify-between text-[10px] text-[#6B778C]">
                  <span className="truncate max-w-[110px]" title={attachment.fileName}>
                    {attachment.fileName}
                  </span>
                  <span>{formatBytes(attachment.fileSize)}</span>
                </div>
              </div>
            )
          })}

          {/* Quick Add Card */}
          <button
            type="button"
            disabled={isUploading}
            onClick={() => fileInputRef.current?.click()}
            className="aspect-4/3 border border-dashed border-[#DFE1E6] hover:border-[#0052CC] hover:bg-white rounded-lg flex flex-col items-center justify-center gap-1 text-[#6B778C] hover:text-[#0052CC] transition cursor-pointer text-xs"
          >
            <UploadCloud className="w-4 h-4 text-[#0052CC]" />
            <span className="text-[11px] font-medium">Add Image</span>
          </button>
        </div>
      )}

      {/* FULLSCREEN LIGHTBOX */}
      {lightboxIndex !== null && attachments[lightboxIndex] && (
        <div
          className="fixed inset-0 z-60 bg-black/85 backdrop-blur-md flex flex-col select-none"
          onClick={() => {
            setLightboxIndex(null)
            setZoomLevel(1)
          }}
        >
          {/* Header */}
          <div
            className="px-4 py-3 bg-black/40 border-b border-white/10 flex items-center justify-between text-white shrink-0"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center gap-2 min-w-0">
              <span className="text-sm font-semibold truncate">
                {attachments[lightboxIndex].fileName}
              </span>
              <span className="text-xs text-white/60">
                ({lightboxIndex + 1} of {attachments.length})
              </span>
            </div>

            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => setZoomLevel((z) => Math.max(0.5, z - 0.25))}
                title="Zoom Out"
                className="p-1.5 rounded-lg hover:bg-white/10 text-white/80 hover:text-white transition cursor-pointer"
              >
                <ZoomOut className="w-4 h-4" />
              </button>
              <button
                type="button"
                onClick={() => setZoomLevel(1)}
                title="Reset Zoom"
                className="px-2 py-1 rounded-lg hover:bg-white/10 text-xs font-mono text-white/80 hover:text-white transition cursor-pointer"
              >
                {Math.round(zoomLevel * 100)}%
              </button>
              <button
                type="button"
                onClick={() => setZoomLevel((z) => Math.min(3, z + 0.25))}
                title="Zoom In"
                className="p-1.5 rounded-lg hover:bg-white/10 text-white/80 hover:text-white transition cursor-pointer"
              >
                <ZoomIn className="w-4 h-4" />
              </button>

              <div className="h-4 w-px bg-white/20 mx-1" />

              <a
                href={attachments[lightboxIndex].publicUrl}
                download={attachments[lightboxIndex].fileName}
                target="_blank"
                rel="noopener noreferrer"
                title="Download"
                className="p-1.5 rounded-lg hover:bg-white/10 text-white/80 hover:text-white transition"
              >
                <Download className="w-4 h-4" />
              </a>

              <button
                type="button"
                onClick={() => {
                  setLightboxIndex(null)
                  setZoomLevel(1)
                }}
                title="Close (Esc)"
                className="p-1.5 rounded-lg hover:bg-white/10 text-white/80 hover:text-white transition cursor-pointer ml-1"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>

          {/* Image Display */}
          <div
            className="flex-1 relative flex items-center justify-center p-4 overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            {attachments.length > 1 && (
              <button
                type="button"
                onClick={() => {
                  setLightboxIndex((prev) =>
                    prev !== null && prev > 0 ? prev - 1 : attachments.length - 1
                  )
                  setZoomLevel(1)
                }}
                className="absolute left-4 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-black/50 hover:bg-black/80 text-white flex items-center justify-center transition cursor-pointer z-10"
              >
                <ChevronLeft className="w-6 h-6" />
              </button>
            )}

            <div className="max-w-full max-h-full overflow-auto flex items-center justify-center p-2">
              <img
                src={attachments[lightboxIndex].publicUrl}
                alt={attachments[lightboxIndex].fileName}
                style={{
                  transform: `scale(${zoomLevel})`,
                  transition: 'transform 0.15s ease-out',
                }}
                className="max-h-[82vh] max-w-[90vw] object-contain rounded-lg shadow-2xl"
              />
            </div>

            {attachments.length > 1 && (
              <button
                type="button"
                onClick={() => {
                  setLightboxIndex((prev) =>
                    prev !== null && prev < attachments.length - 1 ? prev + 1 : 0
                  )
                  setZoomLevel(1)
                }}
                className="absolute right-4 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-black/50 hover:bg-black/80 text-white flex items-center justify-center transition cursor-pointer z-10"
              >
                <ChevronRight className="w-6 h-6" />
              </button>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
